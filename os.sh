#!/bin/bash

# --------------------
# Termux-os Installer
# --------------------
# A script for setting up Termux with a Zsh shell, themes, plugins, and other customizations.
# Dynamically adapts to the user's environment using their .bashrc.

# --------------------
# Global Variables
# --------------------
RED="\e[31m"
CYAN="\e[96m"
BLUE="\e[94m"
GREEN="\e[92m"
YELLOW="\e[93m"
WHITE="\e[97m"
RESET="\e[0m"

# Dynamically determine directories and files
TERMUX_DIR="$HOME/.termux"
OH_MY_ZSH_DIR="$HOME/.oh-my-zsh"
BACKUP_FILE="$HOME/termux_backup.tar.gz"
BASHRC_FILE="$HOME/.bashrc"

# --------------------
# Functions
# --------------------

# Display a Banner
banner() {
    clear
    echo -e "${RED} ________    _____   ______       __    __     __    __   __     __  "
    echo -e "${RED}(___  ___)  / ___/  (   __ \      \ \  / /     ) )  ( (  (_ \   / _) "
    echo -e "${CYAN}    ) )    ( (__     ) (__) )     () \/ ()    ( (    ) )   \ \_/ /   "
    echo -e "${CYAN}   ( (      ) __)   (    __/      / _  _ \     ) )  ( (     \   /   "
    echo -e "${BLUE}    ) )    ( (       ) \ \  _    / / \/ \ \   ( (    ) )    / _ \    "
    echo -e "${BLUE}   ( (      \ \___  ( ( \ \_))  /_/      \_\   ) \__/ (   _/ / \ \_  "
    echo -e "${GREEN}   /__\      \____\  )_) \__/  (/          \)  \______/  (__/   \__)"
    echo ""
    echo -e "${YELLOW} Termux-os Installer by FutureTonight${RESET}"
    echo ""
}

# Error Handling
handle_error() {
    echo -e "${RED}Error: $1${RESET}"
    exit 1
}

# Revert Decision
revert_decision() {
    echo -e "${YELLOW}Would you like to revert this action and choose another option? (y/n)${RESET}"
    read -p "Your choice: " revert_choice
    case $revert_choice in
        y|Y)
            echo -e "${GREEN}Reverting the previous action and returning to the main menu...${RESET}"
            menu
            ;;
        n|N)
            echo -e "${GREEN}Continuing with the current setup...${RESET}"
            ;;
        *)
            echo -e "${RED}Invalid input. Returning to the menu anyway.${RESET}"
            menu
            ;;
    esac
}

# Update and Install Base Packages
necessary_setup() {
    echo -e "${GREEN}Updating packages and installing dependencies...${RESET}"
    apt update && apt upgrade -y || handle_error "Failed to update packages"
    for pkg in zsh git figlet toilet ruby wget curl exa; do
        pkg install "$pkg" -y || handle_error "Failed to install $pkg"
    done
    gem install lolcat || handle_error "Failed to install lolcat"
    echo -e "${GREEN}Base setup complete.${RESET}"
    revert_decision
}

# Configure Zsh and Oh My Zsh
zsh_setup() {
    echo -e "${GREEN}Setting up Zsh and Oh My Zsh...${RESET}"

    # Backup existing Zsh configuration
    [ -f "$HOME/.zshrc" ] && mv "$HOME/.zshrc" "$HOME/.zshrc.bak"

    # Clone Oh My Zsh repository
    git clone https://github.com/ohmyzsh/ohmyzsh.git "$OH_MY_ZSH_DIR" || handle_error "Failed to clone Oh My Zsh"

    # Copy the template Zsh configuration
    cp "$OH_MY_ZSH_DIR/templates/zshrc.zsh-template" "$HOME/.zshrc" || handle_error "Failed to copy Zsh configuration"

    # Append Zsh setup to .bashrc
    if ! grep -q "exec zsh" "$BASHRC_FILE"; then
        echo "exec zsh" >> "$BASHRC_FILE"
    fi

    echo -e "${GREEN}Zsh setup complete.${RESET}"
    revert_decision
}


apply_themes() {
    echo -e "${CYAN}Applying themes...${RESET}"

    # Define repository URL for fetching missing files
    REPO_URL="https://raw.githubusercontent.com/futuretonight/Termux-os/master/.object"

    # Ensure .termux directory exists locally
    mkdir -p .termux || handle_error "Failed to create local .termux directory"

    # Function to download files using wget or curl
    fetch_file() {
        local file_name=$1
        local target_path=$2
        
        # Try wget first
        if command -v wget > /dev/null; then
            wget -q "$REPO_URL/$file_name" -O "$target_path" || return 1
        # Fallback to curl
        elif command -v curl > /dev/null; then
            curl -s "$REPO_URL/$file_name" -o "$target_path" || return 1
        else
            return 1
        fi
    }

    # Check and fetch alternative theme files dynamically
    if [ ! -f ".object/.h4Ck3r.zsh-theme" ]; then
        echo -e "${YELLOW}Missing '.h4Ck3r.zsh-theme'. Fetching from repository...${RESET}"
        fetch_file ".h4Ck3r.zsh-theme" ".object/.h4Ck3r.zsh-theme" || handle_error "Failed to fetch '.h4Ck3r.zsh-theme' from repository"
    fi

    # Apply the downloaded file as the theme
    mkdir -p "$TERMUX_DIR" || handle_error "Failed to create Termux directory in home"
    cp .object/.h4Ck3r.zsh-theme "$TERMUX_DIR/colors.properties" || handle_error "Failed to apply theme"

    # Reload Termux settings
    termux-reload-settings || handle_error "Failed to reload Termux settings"
    echo -e "${GREEN}Themes applied successfully.${RESET}"

    revert_decision
}
# Backup and Restore Configurations
backup_restore() {
    echo -e "${BLUE}1. Backup current configuration"
    echo -e "2. Restore configuration${RESET}"
    read -p "Choose an option (1/2): " choice
    case $choice in
        1)
            tar -czvf "$BACKUP_FILE" "$HOME/.zshrc" "$TERMUX_DIR" || handle_error "Failed to create backup"
            echo -e "${GREEN}Backup saved to $BACKUP_FILE.${RESET}"
            ;;
        2)
            [ -f "$BACKUP_FILE" ] || handle_error "No backup file found"
            tar -xzvf "$BACKUP_FILE" -C "$HOME" || handle_error "Failed to restore backup"
            echo -e "${GREEN}Configuration restored from $BACKUP_FILE.${RESET}"
            ;;
        *)
            echo -e "${RED}Invalid option. Returning to menu.${RESET}"
            ;;
    esac
    revert_decision
}

# Display Menu
menu() {
    banner
    echo -e "${YELLOW}What would you like to do?${RESET}"
    echo -e "${YELLOW}[1] Necessary Setup${RESET} - Update and install essential packages for Termux."
    echo -e "${YELLOW}[2] Zsh Setup${RESET} - Set up Zsh shell and install Oh My Zsh."
    echo -e "${YELLOW}[3] Apply Themes${RESET} - Customize Termux appearance with themes."
    echo -e "${YELLOW}[4] Backup and Restore Configurations${RESET} - Backup or restore your Termux configurations."
    echo -e "${YELLOW}[5] Exit${RESET} - Exit the installer."

    read -p "Choose an option: " choice
    case $choice in
        1) necessary_setup ;;
        2) zsh_setup ;;
        3) apply_themes ;;
        4) backup_restore ;;
        5) echo -e "${GREEN}Exiting...${RESET}"; exit 0 ;;
        *) echo -e "${RED}Invalid option. Please try again.${RESET}"; menu ;;
    esac
}

# --------------------
# Main Execution
# --------------------
menu
