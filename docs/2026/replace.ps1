# Process all .md files in the current directory
Get-ChildItem -Filter *.md -File | ForEach-Object {
    $file = $_.FullName

    # Read file as a single string (preserves newlines)
    $content = Get-Content $file -Raw

    # Define the exact starting block (handles both CRLF and LF)
    $pattern = "^(---\r?\ncomments: true\r?\n---\r?\n?)"

    if ($content -match $pattern) {
        # Replacement block
        $replacement = "---`ncomments: true`ntags:`n  - 2026`n---`n"

        # Replace only at the start
        $newContent = $content -replace $pattern, $replacement

        # Write back to file
        Set-Content -Path $file -Value $newContent -NoNewline

        Write-Host "Updated: $file"
    }
}