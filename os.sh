clear
echo -e "\e[31m ________    _____   ______       __    __     __    __   __     __  " 
echo -e "\e[31m(___  ___)  / ___/  (   __ \      \ \  / /     ) )  ( (  (_ \   / _) " 
echo -e "\e[96m    ) )    ( (__     ) (__) )     () \/ ()    ( (    ) )   \ \_/ /   " 
echo -e "\e[96m   ( (      ) __)   (    __/      / _  _ \     ) )  ( (     \   /   "  
echo -e "\e[94m    ) )    ( (       ) \ \  _    / / \/ \ \   ( (    ) )    / _ \    " 
echo -e "\e[94m   ( (      \ \___  ( ( \ \_))  /_/      \_\   ) \__/ (   _/ / \ \_  " 
echo -e "\e[92m   /__\      \____\  )_) \__/  (/          \)  \______/  (__/   \__)" 
                    
 
echo -e " \e[91m                                                   ____      _____  " 
echo -e " \e[91m                                                  / __ \    / ____\ " 
echo -e " \e[96m                                                 / /  \ \  ( (___   " 
echo -e " \e[96m                                                ( ()  () )  \___ \  " 
echo -e " \e[1;91m                                    \e[0;31m                  ( ()  () )      ) )" 
echo -e " \e[1;91m Github\e[96m /\e[1;93m futuretonight                          \ \__/ /   ___/ /"  
        "                                                                         \____/   /____/"    
echo ""

banner ( ) {
                  
                  
                  printf ""
                  echo -e "\e[1;31m  [\e[32m√\e[31m] \e[1;91m by \e[1;36mRaj Aryan \e[93m/ \e[100;92myoutube.com/h4ck3r0\e[0m"
                  echo -e "\e[1;31m  [\e[32m√\e[31m] \e[1;91m maintained by \e[1;36mRaj simple \e[93m/ \e[100;92mgithub.com/futuretonight\e[0m"
                  }

                  wr  ( )  {
                               printf "\033[1;91m Invalid input!!!\n"
                               selection
                               }
                               1line() {
                                                         apt update && apt upgrade
                                                         pkg install zsh -y
                                                         pkg install git -y
                                                         pkg install figlet toilet -y
                                                         pkg install ruby  -y
                                                         pkg install wget  -y
                                                       
                                                         gem install lolcat 
                                                         pkg install curl -y
                                                         pkg install zsh -y
                                                         
                                                         clear
                                                         cd ~/Termux-os/.object/ && cp -r 'ANSI Shadow.flf'  $PREFIX/share/figlet/ASCII-Shadow.flf 
                                                         git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
                                                       
                                                         pkg install toilet figlet exa -y
                                                         cd ~/Termux-os/.object
                                                         rm -rf ~/.termux/colors.properties
                                                         rm -rf /data/data/com.termux/files/usr/etc/motd
                                                         cp -r .colors.properties ~/.termux/colors.properties
                                                         cp -r .termux.properties ~/.termux/termux.properties
#!/bin/bash

# ====================
# Termux-os Installer
# ====================
# A script for setting up Termux with a Zsh shell, themes, plugins, and other customizations.

# --------------------
# Global Variables
# --------------------
# Define color codes for better readability
RED="\e[31m"
CYAN="\e[96m"
BLUE="\e[94m"
GREEN="\e[92m"
YELLOW="\e[93m"
WHITE="\e[97m"
RESET="\e[0m"

# Define directories and files
TERMUX_DIR="$HOME/.termux"
OH_MY_ZSH_DIR="$HOME/.oh-my-zsh"
BACKUP_FILE="$HOME/termux_backup.tar.gz"

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

# Update and Install Base Packages
necessary_setup() {
    echo -e "${GREEN}Updating packages and installing dependencies...${RESET}"
    apt update && apt upgrade -y || handle_error "Failed to update packages"
    for pkg in zsh git figlet toilet ruby wget curl exa; do
        pkg install "$pkg" -y || handle_error "Failed to install $pkg"
    done
    gem install lolcat || handle_error "Failed to install lolcat"
    echo -e "${GREEN}Base setup complete.${RESET}"
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

    echo -e "${GREEN}Zsh setup complete.${RESET}"
}

# Apply Themes
apply_themes() {
    echo -e "${CYAN}Applying themes...${RESET}"
    mkdir -p "$TERMUX_DIR" || handle_error "Failed to create Termux directory"
    cp .termux/colors.properties "$TERMUX_DIR/colors.properties" || handle_error "Failed to apply color properties"
    cp .termux/termux.properties "$TERMUX_DIR/termux.properties" || handle_error "Failed to apply Termux properties"
    echo -e "${GREEN}Themes applied.${RESET}"
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
}

# Display Menu
menu() {
    banner
    echo -e "${YELLOW}[1] Necessary Setup${RESET}"
    echo -e "${YELLOW}[2] Zsh Setup${RESET}"
    echo -e "${YELLOW}[3] Apply Themes${RESET}"
    echo -e "${YELLOW}[4] Backup and Restore Configurations${RESET}"
    echo -e "${YELLOW}[5] Exit${RESET}"
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
