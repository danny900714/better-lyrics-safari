#!/usr/bin/env bash

XCODE_PROJECT_PATH="$RUNNER_TEMP/better-lyrics/dist/safari-xcode/Better Lyrics"

MARKETING_VERSION="${RELEASE_NAME%+safari.*}" # Strip the build metadata of RELEASE_NAME
CURRENT_PROJECT_VERSION=$(date +%s)

sed -i '' "s/MARKETING_VERSION = .*;/MARKETING_VERSION = $MARKETING_VERSION;/" "$XCODE_PROJECT_PATH/Better Lyrics.xcodeproj/project.pbxproj"
sed -i '' "s/CURRENT_PROJECT_VERSION = .*;/CURRENT_PROJECT_VERSION = $CURRENT_PROJECT_VERSION;/" "$XCODE_PROJECT_PATH/Better Lyrics.xcodeproj/project.pbxproj"
sed -i '' 's/MACOSX_DEPLOYMENT_TARGET = [^;]*;/MACOSX_DEPLOYMENT_TARGET = "$(RECOMMENDED_MACOSX_DEPLOYMENT_TARGET)";/' "$XCODE_PROJECT_PATH/Better Lyrics.xcodeproj/project.pbxproj"
