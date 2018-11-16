#!/bin/bash

# Should be in: ~/.config/rofi/todo.sh

# Rofi command customization
rofi_command="rofi -hide-scrollbar  -opacity 100"

# Grab the response. Also add -dmenu & -p to the Rofi command line
response=$(cat ~/.config/rofi/todo.txt | $rofi_command -dmenu -p "")

# Send a notification to Dunst.
notify-send "Task" "$response"
