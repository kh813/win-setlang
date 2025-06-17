# PowerShell Script: Set Current User's Display Language to Japanese

# Get the existing language list
$currentLanguageList = Get-WinUserLanguageList

# Add Japanese (ja-JP) to the beginning of the language list.
# If ja-JP is already in the list, remove it once and re-insert it at the beginning to increase its priority.

# Check if ja-JP already exists
$jaJP = $currentLanguageList | Where-Object LanguageTag -eq "ja-JP"

if ($null -ne $jaJP) {
    # If it exists, remove it from the list
    $currentLanguageList.Remove($jaJP)
}

# Create a new WinUserLanguage object and insert it at the beginning
$japaneseLanguage = New-WinUserLanguageList ja-JP
$currentLanguageList.Insert(0, $japaneseLanguage[0])

# Set the new language list
Set-WinUserLanguageList $currentLanguageList

Write-Host "User's display language list has been updated."
Write-Host "Japanese has been set as the top priority language."
Write-Host "To fully apply the changes, please sign out or restart your system."

# Display the current user's language list for verification
Write-Host "`nCurrent User Language List:"
Get-WinUserLanguageList | Select-Object LanguageTag, LanguageDisplayName, Autonym