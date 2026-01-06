# 🚀 Documentación Completa de Compilación y Firma para Flet

Este bloque contiene el `README.md` y el script de PowerShell necesarios para la compilación de tu aplicación 'CajaFuerza', listos para copiar y usar en tu repositorio de GitHub.

**Autor del Manual:** Alfredo García

## 1. Archivo `README.md` (Documentación del Proyecto)

```markdown
# 🚀 CajaFuerza - Proceso de Compilación y Firmado de Android

Este documento detalla el proceso para generar y firmar las aplicaciones APK (prueba) y AAB (publicación) de la aplicación Flet 'CajaFuerza'.

## ⚠️ Nota de Seguridad Crítica

El archivo `clave.jks` es **CRÍTICO** para la identidad de tu aplicación. Si pierdes este archivo o sus contraseñas, **no podrás actualizar tu aplicación** en Google Play Store.

**NO compartas el archivo `clave.jks` públicamente.** Si este repositorio es público, asegúrate de que el archivo `clave.jks` esté listado en un archivo `.gitignore`.

---

## Paso 1: Generar la Clave de Firma (Keystore)

Este paso solo se ejecuta **una vez** para crear el archivo `clave.jks` en la raíz del proyecto.

**Credenciales de Ejemplo:**

| Elemento | Uso | Valor de Ejemplo |
| :--- | :--- | :--- |
| **Alias** | `-alias` | `cajafuerza_alias` |
| **Contraseña Keystore** | `-storepass` | `MiClaveSegura1` |
| **Contraseña Clave** | `-keypass` | `MiClaveSegura2` |

**Comando de Generación (Ejecutar en la raíz del proyecto):**

```bash
keytool -genkeypair -v -keystore clave.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias cajafuerza_alias -storepass MiClaveSegura1 -keypass MiClaveSegura2 -dname "CN=Alfredo Garcia, OU=AG, O=Alferis, L=San Antonio de Los Altos, S=Estado, C=VE"