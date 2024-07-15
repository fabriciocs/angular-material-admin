
# Fix SCSS import paths
$stylesScssPath = "src/styles.scss"
$materialScssPath = "src/scss/_material.scss"

Write-Output "Updating SCSS import paths..."
if (Test-Path $stylesScssPath) {
    $stylesScssContent = Get-Content $stylesScssPath
    if ($stylesScssContent -notcontains "@import '@angular/material/theming';") {
        Add-Content $stylesScssPath "@import '@angular/material/theming';"
        Write-Output "Added Angular Material theming import to $stylesScssPath"
    }
}

if (Test-Path $materialScssPath) {
    $materialScssContent = Get-Content $materialScssPath
    if ($materialScssContent -notcontains "@import '@angular/material/theming';") {
        Add-Content $materialScssPath "@import '@angular/material/theming';"
        Write-Output "Added Angular Material theming import to $materialScssPath"
    }
}

# Ensure Angular Material modules are imported in all relevant module files
$moduleFiles = Get-ChildItem -Path "src/app" -Recurse -Include "*.module.ts"
foreach ($moduleFile in $moduleFiles) {
    $moduleContent = Get-Content $moduleFile.FullName
    if ($moduleContent -notcontains "MatCardModule" -or $moduleContent -notcontains "MatGridListModule") {
        $moduleContent = $moduleContent -replace "(imports:\s*\[.*?\])", "`$1, MatCardModule, MatGridListModule"
        $moduleContent = $moduleContent -replace "(from '@angular/material')", "`$1;\nimport { MatCardModule, MatGridListModule } from '@angular/material'"
        Set-Content $moduleFile.FullName $moduleContent
        Write-Output "Added Angular Material modules to $($moduleFile.FullName)"
    }
}

# Clean npm cache and rebuild project
Write-Output "Cleaning npm cache..."
npm cache clean --force

Write-Output "Building the project..."
ng build --configuration production

Write-Output "Fixes applied and project built successfully."