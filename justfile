set dotenv-load

python := env('PYTHON', 'python')
remote_host := env('REMOTE_HOST')
remote_path := env('REMOTE_PATH')
remote_dst := remote_host + ':' + remote_path

sync := if env('USE_SCP', 'false') == 'true' {
    'ssh ' + remote_host + ' rm -rf ' + remote_path / '*' + ' && scp -r ./_site/* ' + remote_dst
} else {
    env('RSYNC', 'rsync') + ' --recursive --checksum --human-readable --delete _site/ ' + remote_dst + ' --info=progress2'
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


# Create and edit a new notice
new title:
    #!pwsh
    $month = Get-Date -Format 'yyyy-MM'
    $filepath = "./_notices/$month-{{ title }}.md"
    Write-Host "Creating “$filepath” …"
    New-Item $filepath

    if ($?) {
        $date = Get-Date -Format 'yyyy-MM-dd'
        "---`ntitle: `nsource: `nstatus: active`nupdated_on:`n  - $date`n---" > $filepath

        & $filepath
    }


# Ripgrep in the notices
rg pattern *options:
    rg "{{ pattern }}" ./_notices/ --no-ignore {{ options }}

# Find files in the notices
fd pattern *options:
    fd "{{ pattern }}" ./_notices/ --no-ignore-vcs {{ options }}
