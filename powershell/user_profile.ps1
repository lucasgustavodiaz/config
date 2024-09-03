# Prompt
Import-Module posh-git
Import-Module -Name Terminal-Icons
Import-Module PSReadLine

# Set Startship has default promt
# Invoke-Expression (&starship init powershell)

# Set oh-my-posh has default promt
$omp_config = Join-Path $PSScriptRoot ".\luks.omp.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

# PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Env
#$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"

# Alias
Set-Alias sudo gsudo
Set-Alias vim nvim
Set-Alias v nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# Neovim Switcher
function nvim_lazy()
{
  $env:NVIM_APPNAME="nvim-lazy"
  nvim $args
}

function nvim_lazy()
{
  $env:NVIM_APPNAME="nvim-astro"
  nvim $args
}

function nvims()
{
  $items = "default", "nvim-lazy", "nvim-astro"
  $config = $items | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0

  if ([string]::IsNullOrEmpty($config))
  {
    Write-Output "Nothing selected"
    break
  }
 
  if ($config -eq "default")
  {
    $config = ""
  }

  $env:NVIM_APPNAME=$config
  nvim $args
}

Clear-Host