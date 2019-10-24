#!/usr/bin/bash

pulse-reconf.py set-rate `pulse-reconf.py get-rates | rofi -dmenu -p "Pick audio sample rate"`
