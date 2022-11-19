set windows-shell := ["pwsh", "-NoLogo", "-Command"]
set dotenv-load

python := env_var_or_default('PYTHON', 'python')
remote_host := env_var('REMOTE_HOST')
remote_path := env_var('REMOTE_PATH')
remote_dst := remote_host + ':' + remote_path

sync := if env_var_or_default('USE_SCP', 'false') == 'true' {
    'ssh ' + remote_host + ' rm -rf ' + remote_path / '*' + ' && scp -r ./_site/* ' + remote_dst
} else {
    'rsync --recursive --checksum --human-readable --delete _site/ ' + remote_dst + ' --info=progress2'
}



# List available recipes
@default:
    just --list


# Jekyll serve
serve:
    bundler exec jekyll serve --incremental


# Archive outdated but active notices
archive:
    {{ python }} "./scripts/archive_notices.py" "./_notices/" --verbose


# Deploy the site
deploy-only $JEKYLL_ENV="production":
    bundler exec jekyll build

    @echo 'Syncing files …'
    {{ sync }}

    @echo '✓ Done.'

# Archive notices and deploy the site
deploy: archive deploy-only
