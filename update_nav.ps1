$navHtml = @"
    <nav>
        <ul style="display: flex; list-style: none; padding: 0; gap: 1rem; margin: 0;">
            <li><a href="/">Home</a></li>
            <li><a href="/blog/">Blog</a></li>
            <li><a href="/tools/">Tools</a></li>
            <li><a href="/contact/">Contact</a></li>
            <li><a href="https://github.com/mds08011/mds08011.github.io">GitHub</a></li>
        </ul>
        <hr>
    </nav>
"@
$files = Get-ChildItem -Path . -Filter "*.html" -Recurse | Where-Object { $_.FullName -notmatch "\\node_modules\\" -and $_.FullName -notmatch "\\.git\\" }
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $modified = $false
    if ($content -match "(?s)<nav>.*?</nav>") {
        $content = $content -replace "(?s)<nav>.*?</nav>", $navHtml
        $modified = $true
    }
    elseif ($content -match "(?i)<body>") {
        $content = $content -replace "(?i)<body>", "<body>`r`n$navHtml"
        $modified = $true
    }
    if ($modified) {
        # Using UTF8 encoding to avoid mangling characters
        [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Updated $($file.FullName)"
    }
}
