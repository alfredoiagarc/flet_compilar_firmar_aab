# compilar_firmar.ps1
# Script para compilar y firmar AAB y APK para publicación en Flet/Flutter.

# Configurar codificación UTF-8
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$inicio = Get-Date
Write-Host "🚀 Iniciando proceso de Compilación y Firmado..." -ForegroundColor Cyan

# --- 1. CONFIGURACIÓN DE FIRMA (ACTUALIZA ESTOS VALORES) ---
# Usamos las credenciales generadas en el Paso 1 del README.
$Alias = "cajafuerza_alias"
$KeystoreFile = "clave.jks"

# 🚨 ACTUALIZA ESTAS CONTRASEÑAS CON TUS VALORES REALES 🚨
$KeystorePassword = "MiClaveSegura1" 
$KeyPassword = "MiClaveSegura2"

# Establecer variables de entorno para las contraseñas
$env:FLET_ANDROID_SIGNING_KEY_STORE_PASSWORD = $KeystorePassword
$env:FLET_ANDROID_SIGNING_KEY_PASSWORD = $KeyPassword

# Detener procesos de Java (Gradle daemon)
Stop-Process -Name "java" -Force -ErrorAction SilentlyContinue

# Resolver ruta absoluta del keystore
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$KeyStorePath = Join-Path $ScriptDir $KeystoreFile

if (-not (Test-Path $KeyStorePath)) {
    Write-Host "🔴 ERROR CRÍTICO: No se encontró el archivo keystore en '$KeyStorePath'." -ForegroundColor Red
    Write-Host "Ejecuta el 'Paso 1: Generar la Clave de Firma' del README.md." -ForegroundColor Red
    exit 1
}
Write-Host "🔑 Usando Keystore en: $KeyStorePath" -ForegroundColor Yellow

# --- 2. FUNCIÓN DE COMPILACIÓN GENÉRICA ---
function Invoke-FletBuild {
    param(
        [string]$Type, # 'aab' o 'apk'
        [string]$OutputPath # Path de salida esperado
    )
    
    Write-Host "`n🔨 Ejecutando flet build $Type y firmando..." -ForegroundColor Yellow
    
    # Comando de Flet para compilar y aplicar la firma
    flet build $Type -vv `
        --android-signing-key-store "$KeyStorePath" `
        --android-signing-key-alias "$Alias"

    if ($LASTEXITCODE -ne 0) {
        Write-Host "🔴 ERROR: La compilación de Flet para $Type falló ($LASTEXITCODE). Revisa las contraseñas y el log." -ForegroundColor Red
        exit 1
    }
    
    Write-Host "✅ Archivo $Type generado con éxito en $OutputPath" -ForegroundColor Green
}

# --- 3. EJECUTAR COMPILACIÓN AAB (Google Play) ---
Invoke-FletBuild -Type "aab" -OutputPath "build\aab\app-release.aab"

# --- 4. EJECUTAR COMPILACIÓN APK (Pruebas) ---
# Opcional, pero útil para testing
Invoke-FletBuild -Type "apk" -OutputPath "build\app\app-release.apk"


# --- 5. FIN DEL PROCESO ---
$fin = Get-Date
$tiempo = ($fin - $inicio).ToString('mm\:ss')

[console]::beep(1000, 400)
Write-Host "`n"
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
Write-Host "✨ PROCESO DE COMPILACIÓN FINALIZADO" -ForegroundColor Green
Write-Host "⏱️  Duración: $tiempo" -ForegroundColor Yellow
Write-Host "▶️ AAB listo para Google Play: build\aab\app-release.aab" -ForegroundColor Cyan
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray