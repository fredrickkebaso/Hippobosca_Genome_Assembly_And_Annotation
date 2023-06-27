#Install the brightness package

# sudo apt install brightnessctl

#List the available devices

brightnessctl -l

#Get the device name for your keyboard backlight. In the output of the previous command, look for a line that starts with "keyboard". The device name will be enclosed in double quotes. For example, my device name is "asus::kbd_backlight".
# Set the brightness with the following command:

# sudo brightnessctl --device='{device name}' s {set amount}


