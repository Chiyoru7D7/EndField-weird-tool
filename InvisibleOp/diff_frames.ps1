# diff_frames.ps1 — Extract PS hashes from two frame dumps, find skill-only hashes
# Usage: .\diff_frames.ps1 -Idle <idle_dir> -Skill <skill_dir>
#   OR put both FrameAnalysis dirs under EFMI and run without params (auto-picks last two)

param(
    [string]$IdleFrame,
    [string]$SkillFrame
)

$EFMI = "$env:APPDATA\XXMI Launcher\EFMI"

# Auto-detect last two frame dumps if not specified
if (-not $IdleFrame -or -not $SkillFrame) {
    $dirs = Get-ChildItem $EFMI -Directory -Filter "FrameAnalysis-*" | Sort-Object LastWriteTime -Descending
    if ($dirs.Count -lt 2) {
        Write-Host "Need 2 frame dumps. Found $($dirs.Count). Take idle + skill frames first."
        exit 1
    }
    $SkillFrame = $dirs[0].FullName
    $IdleFrame = $dirs[1].FullName
}

Write-Host "Idle frame : $IdleFrame"
Write-Host "Skill frame: $SkillFrame"
Write-Host ""

function Get-PSHash($dir) {
    (Get-ChildItem $dir -Name) |
        Select-String -Pattern 'ps=([0-9a-f]{16})' -AllMatches |
        ForEach-Object { $_.Matches } |
        ForEach-Object { $_.Groups[1].Value } |
        Sort-Object -Unique
}

$idle = Get-PSHash $IdleFrame
$skill = Get-PSHash $SkillFrame

$only_skill = $skill | Where-Object { $_ -notin $idle }

Write-Host "Idle unique PS hashes : $($idle.Count)"
Write-Host "Skill unique PS hashes: $($skill.Count)"
Write-Host ""

if ($only_skill.Count -eq 0) {
    Write-Host "No new hashes in skill frame. Boss might not have been casting, or skill uses same shaders."
    exit 0
}

Write-Host "=== Skill-only hashes ($($only_skill.Count)) — add these to mod.ini ==="
Write-Host ""

$i = 1
$only_skill | ForEach-Object {
    Write-Host "[ShaderOverrideBossSkill_$($i.ToString('00'))]"
    Write-Host "Hash = $_"
    Write-Host 'if $invisible == 1 && $hide_bosses == 1'
    Write-Host '  handling = skip'
    Write-Host 'endif'
    Write-Host ""
    $i++
}
