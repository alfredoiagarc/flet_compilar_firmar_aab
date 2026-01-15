# ESPAÑOL
# 🚀 MiAPP - Proceso de Compilación y Firmado de Android

Este documento detalla el proceso para generar y firmar la aplicación AAB (publicación) de la aplicación Flet 'MiAPP'.

## ⚠️ Nota de Seguridad Crítica

El archivo `clave.jks` es CRÍTICO para la identidad de tu aplicación. 
Si pierdes este archivo o sus contraseñas, no podrás actualizar tu aplicación en Google Play Store.

NO compartas el archivo `clave.jks` públicamente. Si este repositorio es público, asegúrate de que el archivo `clave.jks` esté listado en un archivo `.gitignore`.

---

## Generar la Clave de Firma (Keystore)

Este paso solo se ejecuta una vez para crear el archivo `clave.jks` en la raíz del proyecto.

Credenciales de Ejemplo:

| Elemento | Uso | Valor de Ejemplo |
| :--- | :--- | :--- |
| **Alias** | `-alias` | `miapp` |
| **Contraseña Keystore** | `-storepass` | `MiClaveSegura1` |
| **Contraseña Clave** | `-keypass` | `MiClaveSegura2` |

Comando de Generación (Ejecutar en la raíz del proyecto):

```bash
keytool -genkeypair -v -keystore clave.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias miapp -storepass MiClaveSegura1 -keypass MiClaveSegura2 -dname "CN=Alfredo Garcia, OU=AG, O=Alferis, L=San Antonio de Los Altos, S=Estado, C=VE"
```
____

Copiar el archivo clave.jks en la ruta build/flutter/android/app



____
____
____
# ENGLISH
# 🚀 MiAPP - Android Build and Signing Process

This document details the process for generating and signing the AAB (release) package for the Flet application 'MiAPP'.

## ⚠️ Critical Security Note

The `clave.jks` file is CRITICAL to your application's identity. 
If you lose this file or its passwords, you will be unable to update your application on the Google Play Store.

DO NOT share the `clave.jks` file publicly. If this repository is public, ensure that the `clave.jks` file is listed in a `.gitignore` file.

---

## Generating the Signing Key (Keystore)

This step is performed only once to create the `clave.jks` file in the project root.

Example Credentials:

| Item | Usage | Example Value |
| :--- | :--- | :--- |
| **Alias** | `-alias` | `miapp` |
| **Keystore Password** | `-storepass` | `MiClaveSegura1` |
| **Key Password** | `-keypass` | `MiClaveSegura2` |

Generation Command (Execute in the project root):

```bash
keytool -genkeypair -v -keystore clave.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias miapp -storepass MiClaveSegura1 -keypass MiClaveSegura2 -dname "CN=Alfredo Garcia, OU=AG, O=Alferis, L=San Antonio de Los Altos, S=Estado, C=VE"
```

Copy the key.jks file to the build/flutter/android/app path.
