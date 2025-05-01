#!/usr/bin/bash
# Maintained by: futuretonight
# Repository: https://github.com/futuretonight/Termux-os
# Description: This script customizes the Zsh shell theme for Termux users.

# Function to position the cursor on the terminal
PUT() {
    echo -en "\033[${1};${2}H"
}

# Clear the terminal
clear

# Display the banner with a custom design
toilet -t -f mono12 "H4Ck3R" --gay -F border
echo ""

# Display credits
PUT 11 40
echo -e "\e[92mBy \e[1;93mRajAryan\e[1;95m /\e[1;96m H4Ck3R0 \e[92m| Maintained by \e[1;93mfuturetonight"
PUT 12 3
echo ""
echo -e "\e[1;31m  [\e[32m√\e[31m] \e[1;91m Script maintained by \e[1;36mfuturetonight \e[93m/ \e[100;92mhttps://github.com/futuretonight\e[0m"
echo ""
echo -e "  \e[101;1;39mNOTE\e[0;1;33m Use up to 9 words for the shell name.\e[0m"
echo ""

# Navigate to the Termux-os object directory
cd ~/Termux-os/.object || {
    echo -e "\e[1;91mError: Failed to navigate to the Termux-os object directory.\e[0m"
    exit 1
}

# Prompt the user for a shell name
echo -e '\e[1;96m'
read -p '  Type Shell Name ❯ ' name

# Replace the placeholder "H4ck3r" in the theme with the provided shell name
if [ -f ".h4Ck3r.zsh-theme" ]; then
    sed -e "s/\H4ck3r/$name/g" .h4Ck3r.zsh-theme > "$HOME/.oh-my-zsh/themes/h4Ck3r.zsh-theme"
    echo -e "\e[1;92mShell name updated successfully in the Zsh theme.\e[0m"
else
    echo -e "\e[1;91mError: Theme file '.h4Ck3r.zsh-theme' not found.\e[0m"
    exit 1
fi
