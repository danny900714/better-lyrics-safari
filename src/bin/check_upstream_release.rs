use anyhow::{Context, bail};
use octocrab::Octocrab;
use semver::Version;
use tokio::fs::File;
use tokio::io::AsyncWriteExt;

const UPSTREAM_OWNER: &str = "better-lyrics";
const UPSTREAM_REPO: &str = "better-lyrics";

#[tokio::main]
async fn main() -> Result<(), anyhow::Error> {
    // Get GITHUB_TOEKN from environment variables
    let token = std::env::var("GITHUB_TOKEN").ok();
    let builder = Octocrab::builder();
    let octocrab = if let Some(token) = token {
        builder.personal_token(token).build()?
    } else {
        builder.build()?
    };

    // Get the current repository from GITHUB_REPOSITORY environment variable
    let repository = std::env::var("GITHUB_REPOSITORY")
        .context("Failed to get GITHUB_REPOSITORY environment variable")?;
    let split_repository = repository.splitn(2, '/').collect::<Vec<&str>>();
    if split_repository.len() != 2 {
        bail!("GITHUB_REPOSITORY must be in the format owner/repo");
    }

    // Get the latest release from the upstream repository and the current repository
    // If the latest release from the current repository is not found, it will return None without returning an error
    let upstream_repo = octocrab.repos(UPSTREAM_OWNER, UPSTREAM_REPO);
    let upstream_repo_release = upstream_repo.releases();
    let current_repo = octocrab.repos(split_repository[0], split_repository[1]);
    let current_repo_release = current_repo.releases();
    let (upstream_release_result, current_release_result) = tokio::join!(
        upstream_repo_release.get_latest(),
        current_repo_release.get_latest()
    );
    let upstream_release =
        upstream_release_result.context("Failed to get the latest upstream release")?;
    let current_release = current_release_result
        .map(Some)
        .or_else(|e| {
            if let octocrab::Error::GitHub { source, .. } = &e
                && source.status_code == 404
            {
                Ok(None)
            } else {
                Err(e)
            }
        })
        .context("Failed to get the latest release for the current repository")?;

    println!("Latest upstream version: {}", upstream_release.tag_name);
    println!(
        "Latest current version: {}",
        current_release
            .as_ref()
            .map(|r| &r.tag_name as &str)
            .unwrap_or("None")
    );

    if let Some(current_release) = current_release {
        let upstream_version = Version::parse(
            upstream_release
                .tag_name
                .strip_prefix("v")
                .unwrap_or(&upstream_release.tag_name),
        )
        .context("Failed to parse the tag name of the upstream release as SemVer")?;
        let current_version = Version::parse(
            current_release
                .tag_name
                .strip_prefix("v")
                .unwrap_or(&current_release.tag_name),
        )
        .context("Failed to parse the tag name of the current release as SemVer")?;

        if upstream_version > current_version {
            set_output(&upstream_release.tag_name).await?;
        }
    } else {
        set_output(&upstream_release.tag_name).await?;
    }

    Ok(())
}

async fn set_output(new_upstream_version: &str) -> Result<(), anyhow::Error> {
    let output = format!("new-upstream-version={}", new_upstream_version);

    let github_output_env = std::env::var("GITHUB_OUTPUT")
        .context("Failed to get the GITHUB_OUTPUT environment variable")?;
    let mut github_output = File::options()
        .append(true)
        .open(&github_output_env)
        .await
        .context("Failed to open the GITHUB_OUTPUT file in append mode")?;

    github_output
        .write_all(output.as_bytes())
        .await
        .context("Failed to write to the GITHUB_OUTPUT file")?;

    Ok(())
}
