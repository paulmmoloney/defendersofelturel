Get-ChildItem -Path . -Recurse -Filter *.md | ForEach-Object {
    $file = $_.FullName
    $content = Get-Content $file -Raw -ErrorAction SilentlyContinue

    if (-not $content) {
        Write-Host "Skipped (empty or unreadable): $file"
        return
    }

    $old = @"
---
comments: true
---
"@

    $new = @"
---
comments: true
tags:
  - 2023
---
"@

    if ($content.StartsWith($old)) {
        $updated = $new + $content.Substring($old.Length)
        Set-Content -Path $file -Value $updated -Encoding UTF8
        Write-Host "Updated: $file"
    }
}