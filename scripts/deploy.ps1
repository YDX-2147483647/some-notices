# Usage: ./scripts/deploy.ps1

Write-Host 'Building …'
$env:JEKYLL_ENV = 'production'
bundler exec jekyll build

Write-Host 'Syncing files …'
rsync --recursive --checksum --human-readable --delete _site/ SomeNotices:/var/www/html/ --info=progress2
# For those who cannot rsync:
# scp 只会用新文件覆盖旧文件，不会单独删除旧文件。
# ssh SomeNotices rm -rf /var/www/html/*
# scp -r ./_site/* SomeNotices:/var/www/html/

# Write-Host 'Reloading the server …'
# ssh SomeNotices sudo -t nginx -s reload

Write-Host '✓ Done.'
