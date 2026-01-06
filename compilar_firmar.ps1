# Configurar codificación UTF-8 para evitar caracteres extraños
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$inicio = Get-Date
Write-Host "🚀 Iniciando compilación..." -ForegroundColor Cyan

# Detener procesos de Java (Gradle daemon) para liberar archivos bloqueados
Stop-Process -Name "java" -Force -ErrorAction SilentlyContinue

flet build aab --android-signing-key-store clave.jks --android-signing-key-alias "miapp"

# Copiar el archivo generado a la ruta deseada
Copy-Item "build\aab\app-release.aab" "C:\Servidores\crypteris\build\aab\miapp.aab"
# Eliminar el archivo original
Remove-Item "build\aab\app-release.aab"

$fin = Get-Date
$tiempo = ($fin - $inicio).ToString('mm\:ss')

# Sonido y mensaje final
[console]::beep(1000, 400)
Write-Host "`n"
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
Write-Host "✅ APK GENERADO CON ÉXITO" -ForegroundColor Green
Write-Host "⏱️  Duración: $tiempo" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray