# fix-project.ps1

Write-Output "Fixing Angular Project Issues..."

# Ensure Angular Material and necessary packages are installed
Write-Output "Installing Angular Material and dependencies..."
npm install @angular/material @angular/cdk @angular/animations --save

# Ensure ng2-charts is installed
Write-Output "Installing ng2-charts..."
npm install ng2-charts --save

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

# Ensure Angular Material modules are imported
$appModulePath = "src/app/app.module.ts"
if (Test-Path $appModulePath) {
    $appModuleContent = Get-Content $appModulePath
    if ($appModuleContent -notcontains "MatCardModule" -or $appModuleContent -notcontains "MatGridListModule") {
        $appModuleContent = $appModuleContent -replace "(imports:\s*\[.*?\])", "`$1, MatCardModule, MatGridListModule"
        $appModuleContent = $appModuleContent -replace "(from '@angular/material')", "`$1;\nimport { MatCardModule, MatGridListModule } from '@angular/material'"
        Set-Content $appModulePath $appModuleContent
        Write-Output "Added Angular Material modules to $appModulePath"
    }
}

# Clean npm cache and rebuild project
Write-Output "Cleaning npm cache..."
npm cache clean --force

Write-Output "Building the project..."
ng build --configuration production

Write-Output "Fixes applied and project built successfully."
