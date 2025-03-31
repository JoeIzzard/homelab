changelog:
  git cliff --config cliff.toml --output CHANGELOG.md

changelog-auto:
  git cliff --config cliff.toml --output CHANGELOG.md
  git add CHANGELOG.md
  git commit --amend --no-edit

build-env:
  op inject -i .env.1password -o .env

clear-env:
  unset B2_APPLICATION_KEY_ID
  unset B2_APPLICATION_KEY
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset OP_SERVICE_ACCOUNT_TOKEN
