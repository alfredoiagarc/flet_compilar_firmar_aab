# Configurar codificación UTF-8 para evitar caracteres extraños
# Configure UTF-8 encoding to avoid strange characters
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$inicio = Get-Date
Write-Host "🚀 Iniciando compilación..." -ForegroundColor Cyan

# Detener procesos de Java (Gradle daemon) para liberar archivos bloqueados
# Stop Java processes (Gradle daemon) to release locked files
Stop-Process -Name "java" -Force -ErrorAction SilentlyContinue

# Copiar el archivo clave.jks a la carpeta de construcción
# Copy the key.jks file to the build folder
Copy-Item "clave.jks" "build\flutter\android\app\"

# Compilar y firmar el AAB
# Compile and sign the AAB
flet build aab --android-signing-key-store clave.jks --android-signing-key-alias "miapp"

# Copiar el archivo generado a la ruta deseada
# Copy the generated file to the desired location
Copy-Item "build\aab\app-release.aab" "C:\Servidores\crypteris\build\aab\miapp.aab"
# Eliminar el archivo original
# Delete the original file
Remove-Item "build\aab\app-release.aab"

$fin = Get-Date
$tiempo = ($fin - $inicio).ToString('mm\:ss')

# Sonido y mensaje final
# Sound and final message
[console]::beep(1000, 400)
Write-Host "`n"
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
Write-Host "✅ APK GENERADO CON ÉXITO" -ForegroundColor Green
Write-Host "⏱️  Duración: $tiempo" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
