param(
  [string]$RepoName = "didi-prompt-tool"
)

$ErrorActionPreference = "Stop"

function Find-GitHubCli {
  $cmd = Get-Command gh -ErrorAction SilentlyContinue
  if ($cmd) { return $cmd.Source }

  $wingetGh = Get-ChildItem -Path "$env:LOCALAPPDATA\Microsoft\WinGet\Packages" -Recurse -Filter gh.exe -ErrorAction SilentlyContinue |
    Select-Object -First 1 -ExpandProperty FullName
  if ($wingetGh) { return $wingetGh }

  throw "GitHub CLI 未安装。请先运行：winget install --id GitHub.cli -e --source winget"
}

$gh = Find-GitHubCli

Write-Host "检查 GitHub 登录状态..."
& $gh auth status *> $null
if ($LASTEXITCODE -ne 0) {
  Write-Host "需要登录 GitHub，接下来会打开浏览器授权。"
  & $gh auth login --hostname github.com --git-protocol https --web
  & $gh auth status
}

$owner = (& $gh api user --jq ".login").Trim()
if (-not $owner) {
  throw "无法读取 GitHub 用户名，请确认 GitHub CLI 已登录。"
}

if (-not (Test-Path ".git")) {
  git init -b main
}

git config user.name $owner
git config user.email "$owner@users.noreply.github.com"

$hasCommit = $true
git rev-parse --verify HEAD *> $null
if ($LASTEXITCODE -ne 0) { $hasCommit = $false }

if (-not $hasCommit) {
  git add index.html styles.css app.js README.md .gitignore favicon.svg assets/hero.png publish-to-github.ps1
  git commit -m "Productize prompt web tool"
}

$repoFullName = "$owner/$RepoName"
& $gh repo view $repoFullName *> $null
if ($LASTEXITCODE -eq 0) {
  throw "GitHub 上已存在仓库 $repoFullName。为避免覆盖已有内容，脚本已停止。"
}

Write-Host "创建公开仓库并推送：$repoFullName"
& $gh repo create $RepoName --public --source . --remote origin --push

Write-Host "开启 GitHub Pages..."
& $gh api --method POST "repos/$repoFullName/pages" -f "source[branch]=main" -f "source[path]=/" *> $null
if ($LASTEXITCODE -ne 0) {
  & $gh api --method PUT "repos/$repoFullName/pages" -f "source[branch]=main" -f "source[path]=/" *> $null
}

Write-Host ""
Write-Host "完成。仓库地址：https://github.com/$repoFullName"
Write-Host "Pages 地址：https://$owner.github.io/$RepoName/"
Write-Host "GitHub Pages 首次生效可能需要等待 1-3 分钟。"
