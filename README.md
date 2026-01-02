# 🎮 SteamOS Utility for ASUS ROG Ally

A streamlined post-install script designed to automate the setup of SteamOS on the ASUS ROG Ally. Skip the manual Googling and Konsole commands—get everything running in seconds.

> [!CAUTION]
> This script was created for personal use. SteamOS updates may occasionally break functionality. If you encounter bugs, please open an issue.

---

## ✨ Features

### 🛠️ Plugin Management
*   **Decky Loader:** Automated install/uninstall of the latest version.
*   **Essential Plugins:** One-click install for:
    *   **AllyCenter:** Specific ROG Ally features ( rgb control and fan modes).
    *   **DeckyPlumber:** Controller mode selection (as ps4 controller).
    *   **PowerControl:** TDP and power management(mainly best feature for ally is better customizable fan control).
    *   **HueSync:** much better RGB control.

### ⚙️ System Tweaks
*   **L5/R5 Paddle Remap:** Correctly maps back paddles (M1/M2) from L4/R4 to L5/R5 to ensure Steam Input profiles work as intended.
*   **Power Management:** Prevents screen dimming and sleeping in Desktop Mode—ideal for long initial setups/downloads.
*   **Firewall Toggle:** Easily Enable/Disable the system firewall.
*   **Shader Optimization:** Configures Vulkan background processing and sets the optimal thread count for shader compilation.

### 📦 Software & Tools
*   **App Installer:** Fast-track install for Discord, Spotify, and more.
*   **Warp CLI:** Includes a Cloudflare Warp installer to fix Steam connection/download issues in restricted regions.
*   **Hardware Info:** Quickly check BIOS and Firmware versions to see if you are up to date.

---

## 🚀 Quick Start

### Option 1: The Fast Way (One-Line Install)
Open **Konsole** and paste the following command:

```bash
bash <(curl -sL https://github.com/triplesixdegrees/ally_tweaks/releases/download/release/ally_tweaks.sh)
```

### Option 2: Manual Installation
*   Download the ally_tweaks.sh from the Releases page.
*   Set Permissions: Right-click the file > Properties > Permissions > Check "Allow executing file as program".
*   Alternatively, run chmod u+x ally_tweaks.sh in the terminal.
*   Run: Right-click the script and select "Run in Konsole" or type ./ally_tweaks.sh in your terminal. 
### ⌨️ Controls
*   Navigation: Type the number corresponding to the feature you want and press Enter.
*   On-Screen Keyboard: While in Desktop Mode, hold the Command Center Button (bottom-left button closest to the screen) and press X. 
### 🔗 Credits
*   Decky Loader ( https://github.com/SteamDeckHomebrew/decky-loader )
*   AllyCenter ( https://github.com/PixelAddictUnlocked/allycenter )
*   DeckyPlumber ( https://github.com/aarron-lee/DeckyPlumber )
*   PowerControl ( https://github.com/mengmeet/PowerControl )
*   HueSync ( https://github.com/honjow/HueSync )
