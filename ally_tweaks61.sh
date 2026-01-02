#!/bin/bash

# Ally Tweaks version 6.1 by triplesixdegrees
# mainly made for myself and with steam updates could break, if something breaks write issues at https://github.com/triplesixdegrees/ally_tweaks

STEAM_DIR="$HOME/.local/share/Steam"
USERDATA_DIR="$STEAM_DIR/userdata"
DEV_CFG="$STEAM_DIR/steam_dev.cfg"
CONFIG_FILE=$(find "$USERDATA_DIR" -name "localconfig.vdf" | head -n 1 2>/dev/null)

show_menu() {
    clear
    echo "======================================"
    echo "           ALLY TWEAKS    v6.1         "
    echo "======================================"
    echo "1) Decky Loader (Install/Uninstall)"
    echo "2) Decky Plugins (AllyCenter, DeckyPlumber, PowerControl, HueSync)"
    echo "3) Discover Apps (Discord, Spotify, etc.)"
    echo "4) Firewall Tweaks (Enable/Disable)"
    echo "5) Power Management (Select Tweaks)"
    echo "6) L5/R5 Paddle Remap (M1/M2 Utility)"
    echo "7) Steam Optimization (Vulkan/Threads)"
    echo "8) BIOS & Firmware Status"
    echo "q) Exit"
    echo "======================================"
    read -p "Select an option: " choice
}

decky_loader() {
    clear
    echo "--- Decky Loader ---"
    echo "1) Install Decky Loader"
    echo "2) Uninstall Decky Loader"
    echo "b) Back"
    read -p "Selection: " decky_choice
    case $decky_choice in
        1) curl -L https://github.com/SteamDeckHomebrew/decky-installer/releases/latest/download/install_release.sh | sh ;;
        2) curl -L https://github.com/SteamDeckHomebrew/decky-installer/releases/latest/download/uninstall.sh | sh ;;
        b) return ;;
    esac
}

bios_check() {
    clear
    echo "--- BIOS & Firmware Information ---"
    bios_ver=$(cat /sys/class/dmi/id/bios_version 2>/dev/null)
    bios_date=$(cat /sys/class/dmi/id/bios_date 2>/dev/null)
    product_name=$(cat /sys/class/dmi/id/product_name 2>/dev/null)
    echo "Device Model: $product_name"
    echo "BIOS Version: $bios_ver"
    echo "Release Date: $bios_date"
    echo "--------------------------------------"
    read -p "Press enter to return..."
}

decky_plugins_menu() {
    while true; do
        clear
        echo "--- Decky Plugins Install ---"
        echo "1) AllyCenter (ROG Ally Features)"
        echo "2) DeckyPlumber (InputPlumber Plugin)"
        echo "3) PowerControl (Fan & TDP Control)"
        echo "4) HueSync (RGB Control Utility)"
        echo "b) Back"
        read -p "Selection: " plugin_choice
        case $plugin_choice in
            1)
                sudo steamos-readonly disable
                curl -L https://github.com/PixelAddictUnlocked/allycenter/raw/main/install.sh | sh
                sudo steamos-readonly enable
                ;;
            2)
                sudo steamos-readonly disable
                curl -L https://github.com/aarron-lee/DeckyPlumber/raw/main/install.sh | sh
                sudo steamos-readonly enable
                ;;
            3)
                sudo steamos-readonly disable
                curl -L https://raw.githubusercontent.com/mengmeet/PowerControl/main/install.sh | sh
                sudo steamos-readonly enable
                ;;
            4)
                sudo steamos-readonly disable
                echo "Installing HueSync for RGB control..."
                curl -L https://raw.githubusercontent.com/honjow/huesync/main/install.sh | sh
                sudo steamos-readonly enable
                ;;
            b) break ;;
        esac
        echo "Task complete. Restart Game Mode to see changes."
        sleep 2
    done
}

install_apps() {
    while true; do
        clear
        echo "--- Select App to Install ---"
        echo "1) Discord"
        echo "2) Vesktop"
        echo "3) Spotify"
        echo "4) Telegram"
        echo "5) Google Chrome"
        echo "6) Heroic Games Launcher"
        echo "7) Cloudflare Warp CLI"
        echo "b) Back"
        read -p "Selection: " app_choice
        case $app_choice in
            1) flatpak install -y flathub com.discordapp.Discord ;;
            2) flatpak install -y flathub dev.vencord.Vesktop ;;
            3) flatpak install -y flathub com.spotify.Client ;;
            4) flatpak install -y flathub org.telegram.desktop ;;
            5) flatpak install -y flathub com.google.Chrome ;;
            6) flatpak install -y flathub com.heroicgameslauncher.hgl ;;
            7) warp_mgmt ;;
            b) break ;;
        esac
        echo "Task complete."
        sleep 1
    done
}

firewall_tweaks() {
    clear
    echo "--- Firewall Management ---"
    echo "1) Enable Firewalld"
    echo "2) Disable Firewalld"
    echo "b) Back"
    read -p "Selection: " fw_choice
    if [ "$fw_choice" == "1" ]; then
        sudo systemctl enable --now firewalld
        echo "Firewall Enabled."
    elif [ "$fw_choice" == "2" ]; then
        sudo systemctl disable --now firewalld
        echo "Firewall Disabled."
    fi
}

power_tweaks() {
    while true; do
        clear
        echo "--- Power Management Tweaks ---"
        echo "1) Disable Auto Dim (Current Session)"
        echo "2) When Inactive: Do Nothing (Inhibit Sleep)"
        echo "3) Turn Off Screen: Never (Disable DPMS)"
        echo "b) Back"
        read -p "Selection: " pwr_choice
        case $pwr_choice in
            1) xset s off; echo "Auto dim disabled." ;;
            2) qdbus org.kde.Solid.PowerManagement /org/kde/Solid/PowerManagement/PolicyAgent \
               org.kde.Solid.PowerManagement.PolicyAgent.AddInhibition 1 "AllyTweaks" "No Sleep"; echo "Sleep inhibited." ;;
            3) xset -dpms; echo "Screen turn-off disabled." ;;
            b) break ;;
        esac
        sleep 1
    done
}

paddle_remap() {
    clear
    echo "--- L5/R5 Capability Map Utility ---"
    echo "1) Apply L5/R5 Remap (M1 -> L5, M2 -> R5)"
    echo "2) Revert to Stock (M1 -> L1, M2 -> R1)"
    echo "b) Back"
    read -p "Selection: " p_choice
    case $p_choice in
        1|2)
            sudo steamos-readonly disable
            if [ "$p_choice" == "1" ]; then
                sudo sed -i 's/button: LeftPaddle1/button: LeftPaddle2/g' /usr/share/inputplumber/capability_maps/ally_type1.yaml
                sudo sed -i 's/button: RightPaddle1/button: RightPaddle2/g' /usr/share/inputplumber/capability_maps/ally_type1.yaml
                msg="Applied: M1->L5, M2->R5"
            else
                sudo sed -i 's/button: LeftPaddle2/button: LeftPaddle1/g' /usr/share/inputplumber/capability_maps/ally_type1.yaml
                sudo sed -i 's/button: RightPaddle2/button: RightPaddle1/g' /usr/share/inputplumber/capability_maps/ally_type1.yaml
                msg="Reverted to Stock"
            fi
            sudo systemctl restart inputplumber
            sudo steamos-readonly enable
            echo "$msg"
            ;;
        b) return ;;
    esac
}

warp_mgmt() {
    clear
    echo "--- Cloudflare Warp Management ---"
    echo "1) Install Warp"
    echo "2) Uninstall Warp"
    echo "b) Back"
    read -p "Selection: " w_choice
    case $w_choice in
        1)
            sudo steamos-readonly disable
            echo "Step 1: Initializing keys..."
            sudo pacman-key --init
            sudo pacman-key --populate archlinux holo

            echo "Step 2: Adding Chaotic-AUR repository (for pre-built Warp)..."
            sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
            sudo pacman-key --lsign-key 3056513887B78AEB
            sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
            sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

            # Add repo to pacman.conf if not already there
            if ! grep -q "\[chaotic-aur\]" /etc/pacman.conf; then
                echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf
            fi

            echo "Step 3: Installing Warp..."
            sudo pacman -Sy --noconfirm cloudflare-warp-bin

            echo "Step 4: Starting Service..."
            sudo systemctl enable --now warp-svc.service
            sudo steamos-readonly enable

            if systemctl is-active --quiet warp-svc; then
                echo "SUCCESS: Warp is running."
                echo "Now run: 'warp-cli registration new' then 'warp-cli connect'"
            else
                echo "ERROR: Installation failed. Target still not found?"
            fi
            ;;
        2)
            sudo steamos-readonly disable
            sudo systemctl disable --now warp-svc.service
            sudo pacman -Rs --noconfirm cloudflare-warp-bin
            sudo steamos-readonly enable
            echo "Warp removed."
            ;;
        b) return ;;
    esac
}


check_config() {
    if [[ -z "$CONFIG_FILE" ]]; then
        echo "ERROR: localconfig.vdf not found! Log into Steam in Desktop Mode first."
        return 1
    fi
    return 0
}

steam_opt() {
    while true; do
        clear
        echo "--- Steam Optimization ---"
        echo "1) Vulkan Background Shaders (Enable/Disable)"
        echo "2) CPU Thread Optimization (unShaderBackgroundProcessingThreads)"
        echo "b) Back"
        read -p "Selection: " opt_choice
        case $opt_choice in
            1)
                echo "1) Enable  2) Disable"
                read -p "Choice: " v_sub
                if [ "$v_sub" == "1" ]; then
                    check_config && {
                        sed -i 's/"BackgroundShaderProcessingEnabled"[[:space:]]*"[0-9]"/"BackgroundShaderProcessingEnabled" "1"/' "$CONFIG_FILE"
                        sed -i 's/"ShaderPrecacheEnabled"[[:space:]]*"[0-9]"/"ShaderPrecacheEnabled" "1"/' "$CONFIG_FILE"
                        echo "Enabled."; }
                elif [ "$v_sub" == "2" ]; then
                    check_config && {
                        sed -i 's/"BackgroundShaderProcessingEnabled"[[:space:]]*"[0-9]"/"BackgroundShaderProcessingEnabled" "0"/' "$CONFIG_FILE"
                        echo "Disabled."; }
                fi
                ;;
            2)
                echo "1) Set Thread Limit  2) Remove Limit"
                read -p "Choice: " t_sub
                if [ "$t_sub" == "1" ]; then
                    read -p "Enter thread count (e.g., 12 for Z1E): " tc
                    echo "unShaderBackgroundProcessingThreads $tc" > "$DEV_CFG"
                    echo "Threads set to $tc."
                elif [ "$t_sub" == "2" ]; then
                    [ -f "$DEV_CFG" ] && rm "$DEV_CFG" && echo "Limit removed."
                fi
                ;;
            b) break ;;
        esac
        sleep 1
    done
}

while true; do
    show_menu
    case $choice in
        1) decky_loader ;;
        2) decky_plugins_menu ;;
        3) install_apps ;;
        4) firewall_tweaks ;;
        5) power_tweaks ;;
        6) paddle_remap ;;
        7) steam_opt ;;
        8) bios_check ;;
        q) exit ;;
        *) echo "Invalid option." ; sleep 1 ;;
    esac
    read -p "Press Enter to continue..." pause
done
