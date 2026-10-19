#!/usr/bin/env bash

# Create variables
SIGNING_CERTIFICATE_PATH="$RUNNER_TEMP/signing-certificate.p12"
KEYCHAIN_PATH="$RUNNER_TEMP/app-signing.keychain-db"

# Import certificate and provisioning profile from secrets
echo -n "$SIGNING_CERTIFICATE_BASE64" | base64 --decode -o "$SIGNING_CERTIFICATE_PATH"

# Create temporary keychain
security create-keychain -p "$KEYCHAIN_PASSWORD" "$KEYCHAIN_PATH"
security set-keychain-settings -lut 1800 "$KEYCHAIN_PATH"
security unlock-keychain -p "$KEYCHAIN_PASSWORD" "$KEYCHAIN_PATH"

# Import signing certificate to keychain
security import "$SIGNING_CERTIFICATE_PATH" -P "$SIGNING_CERTIFICATE_PASSWORD" -A -t cert -f pkcs12 -k "$KEYCHAIN_PATH"
security set-key-partition-list -S apple-tool:,apple: -k "$KEYCHAIN_PASSWORD" "$KEYCHAIN_PATH"
security list-keychain -d user -s "$KEYCHAIN_PATH"
