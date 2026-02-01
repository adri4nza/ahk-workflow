# ⌨️ Guía de Comandos AHK

Resumen de atajos de teclado y funcionalidades del script de automatización personal.

## 🖥️ Gestión de Monitores
*Requiere MultiMonitorTool configurado en `.env`*

| Atajo | Acción |
| :--- | :--- |
| `Ctrl` + `Alt` + `⬆️` | **Horizontal (0°)**: Pone el monitor en posición normal. |
| `Ctrl` + `Alt` + `➡️` | **Vertical (90°)**: Rota la pantalla a la derecha (Modo Código). |
| `Ctrl` + `Alt` + `⬅️` | **Invertido (270°)**: Rota la pantalla a la izquierda. |

## 🔊 Control de Audio
*Requiere SoundVolumeView configurado en `.env`*

| Atajo | Contexto | Acción |
| :--- | :--- | :--- |
| **Scroll Rueda** | Sobre Barra de Tareas | Sube/Baja el **Volumen General** del sistema. |
| **Clic Central** | Sobre Barra de Tareas | **Mute/Unmute** (Silencia) el sistema. |
| `Alt` + **Scroll** | Sobre cualquier ventana | Sube/Baja el volumen **solo de esa App** (ej. Spotify). |

## 🇪🇸 Escritura en Español (Teclado ANSI)
*Usa `Alt Derecho` (>!) para evitar conflictos con atajos del sistema.*

| Atajo | Resultado | Nota |
| :--- | :--- | :--- |
| `Alt Der` + `n` | **ñ** / **Ñ** | `Shift` para mayúscula. |
| `Alt Der` + `a` | **á** | Funciona igual para `e, i, o, u`. |
| `Alt Der` + `?` | **¿** | Signo de apertura de pregunta. |
| `Alt Der` + `1` | **¡** | Signo de apertura de exclamación. |

## 🛠️ Utilidades de Desarrollador

| Atajo | Nombre | Acción |
| :--- | :--- | :--- |
| `Ctrl` + `Espacio` | **Always on Top** | Fija la ventana actual siempre al frente de las demás. |
| `Win` + `Alt` + `C` | **Color Picker** | Copia el código HEX del color bajo el mouse al portapapeles. |
| `clg` + `Espacio` | **Snippet JS** | Escribe `console.log();` y pone el cursor dentro. |

## ⚙️ Control del Script (Workflow)

| Atajo | Acción |
| :--- | :--- |
| `Ctrl` + `Alt` + `R` | **Reload**: Recarga el script para aplicar cambios recientes. |
| `Ctrl` + `Alt` + `E` | **Edit**: Abre la carpeta del proyecto en VS Code. |

---
> **Nota:** Si algún comando de monitor o audio no responde, verifica que las rutas en el archivo `.env` sean correctas y que las herramientas de NirSoft existan en esa ubicación.