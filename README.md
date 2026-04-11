# ⚡ Windows Workflow Automation (AutoHotkey)

Una colección de scripts de **AutoHotkey (v2)** diseñada para desarrolladores Full-Stack y "Power Users". Este proyecto automatiza tareas repetitivas, gestiona monitores verticales, mejora el control de audio por aplicación y soluciona la falta de teclas dedicadas (como la `ñ`) en teclados mecánicos ANSI (Inglés).

## 🚀 Características y Atajos

### 🖥️ Gestión de Monitores
Rotación rápida de pantalla sin entrar a la configuración de Windows. Ideal si alternas tu monitor secundario entre horizontal y vertical para leer código.

| Atajo | Acción |
| :--- | :--- |
| `Ctrl` + `Alt` + `⬆️` | Poner pantalla en **Horizontal** (Normal) |
| `Ctrl` + `Alt` + `➡️` | Poner pantalla en **Vertical** (90°) |
| `Ctrl` + `Alt` + `⬅️` | Poner pantalla en **Vertical Invertido** (270°) |
| `Ctrl` + `Alt` + `P` | Alterna entre **Pantalla Extendida** y **Solo Monitor Principal**. |

### 🔊 Control de Audio Avanzado
| Atajo | Acción |
| :--- | :--- |
| **Mouse sobre Barra de Tareas** + `Scroll` | Sube/Baja el **Volumen Maestro** del sistema. |
| **Mouse sobre Barra de Tareas** + `Clic Central` | Mutea/Desmutea el sistema. |
| `Alt` + `Scroll` (Sobre una ventana) | Sube/Baja el volumen **solo de esa aplicación** (ej. Spotify/YouTube) sin afectar al resto. |

### ⌨️ Productividad y Teclado
| Atajo | Acción |
| :--- | :--- |
| `Ctrl` + `Espacio` | **Always on Top**: Fija la ventana actual siempre visible. |
| `Win` + `Alt` + `C` | **Color Picker**: Copia el HEX del color bajo el mouse al portapapeles. |
| `Alt Derecho` + `n`, `a`, `e`, `i`, `o`, `u` | Escribe ñ, á, é, í, ó, ú. |
| `Alt Derecho` + `?`, `1` | Escribe ¿ y ¡. |
| `clg` + `Espacio` | **Snippet JS** | Escribe `console.log();` y pone el cursor dentro. |

### 🛠️ Mantenimiento del Script (Workflow)
| Atajo | Acción |
| :--- | :--- |
| `Ctrl` + `Alt` + `R` | **Reload**: Recarga el script para aplicar cambios (hace un *beep*). |
| `Ctrl` + `Alt` + `E` | **Edit**: Abre el proyecto completo en VS Code (reconoce Git). |

---

## 📋 Requisitos Previos

Para que este script funcione correctamente, necesitas:

1.  **[AutoHotkey v2](https://www.autohotkey.com/)**: El motor que ejecuta el script.
2.  **Herramientas de NirSoft** (Necesarias para rotar pantalla y controlar audio por app). Descarga las versiones **x64**:
    * [MultiMonitorTool](https://www.nirsoft.net/utils/multi_monitor_tool.html)
    * [SoundVolumeView](https://www.nirsoft.net/utils/sound_volume_view.html)

---

## ⚙️ Instalación y Configuración

### 1. Clonar el repositorio
Abre tu terminal y ejecuta:

```bash
git clone https://github.com/adri4nza/ahk-workflow.git
cd ahk-workflow
```

### 2. Organizar las herramientas
Descarga las herramientas de NirSoft mencionadas arriba, descomprímelas y guárdalas en una carpeta segura (ej: `Documentos/Tools`).

### 3. Configurar el entorno (.env)
Este proyecto usa un archivo `.env` para no "harcodear" rutas personales. Crea un archivo llamado `.env` en la raíz del proyecto y configura tus rutas:

```ini
# RUTA A LAS HERRAMIENTAS (Usa barras invertidas \)
PATH_MONITOR_TOOL="C:\Users\TU_USUARIO\Documents\Tools\multimonitortool-x64\MultiMonitorTool.exe"
PATH_SOUND_VIEW="C:\Users\TU_USUARIO\Documents\Tools\soundvolumeview-x64\SoundVolumeView.exe"

# ID DE TU MONITOR (Para rotación)
# Puedes ver el ID abriendo MultiMonitorTool.exe manualmente.
# Generalmente es \\.\DISPLAY1 o \\.\DISPLAY2
MONITOR_ID="\\.\DISPLAY1"
```

### 4. Ejecutar
Haz doble clic en el archivo `.ahk` principal.

> **Nota:** El script pedirá permisos de Administrador automáticamente (necesarios para controlar ventanas de sistema como el Administrador de Tareas).

## 🤖 Iniciar automáticamente con Windows (Recomendado)
Para evitar el aviso de *"¿Quieres permitir que esta aplicación haga cambios?"* cada vez que inicias la PC, se recomienda usar el **Programador de Tareas**:

1. Abre el "Programador de tareas" de Windows.
2. Crea una nueva tarea llamada `AutoHotkey Script`.
3. Marca la casilla **"Ejecutar con los privilegios más altos"**.
4. En **Desencadenadores**, selecciona "Al iniciar la sesión".
5. En **Acciones**, busca tu archivo `.ahk`.
6. En **Condiciones**, desmarca "Iniciar solo si está conectado a corriente alterna" (vital para laptops).

## 📝 Notas
- El script espera **5 segundos** al iniciar Windows antes de mostrar el icono en la barra de tareas para asegurar que el sistema cargó completamente.
- El modo de escritura para la `ñ` y acentos usa `SendEvent` para ser compatible con apps web como WhatsApp Desktop y Discord.

---
*Made with ❤️ and AHK.*