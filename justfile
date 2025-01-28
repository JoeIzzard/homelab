changelog:
  git cliff --config cliff.toml --output CHANGELOG.md

build-env:
  op inject -i .env.1password -o .env