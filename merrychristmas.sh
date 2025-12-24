#!/usr/bin/env bash
# Copyright (C) 2025 Germán Rocha
# SPDX-License-Identifier: GPL-3.0-or-late


draw_tree() {
	local height="$1"
	local stars=1
	local spaces=$((height - 1))
	
	# Tree
	for ((i = 0; i < height; i++)); do
		for ((x = 0; x < spaces; x++)); do
			echo -n " ";
		done

		for ((y = 0; y < stars; y++)); do
			if [ "$y" -eq 0 ] && [ "$i" -eq 0 ]; then
				# Print star at the top in red
				echo -n -e "\e[31m*\e[0m"
			else
				# Print stars in green
				echo -n -e "\e[32m*\e[0m"
			fi
		done

		spaces=$((spaces - 1))
		stars=$((stars + 2))
	
		echo ""
	done

	# Trunk
	for ((i = 0; i < $((height  / 2)); i++)); do
		for ((j = 0; j < $((height - 1)); j++)); do
		       echo -n " "	
	       done

	       # Print | character in brown
	       echo -e "\e[33m|\e[0m"
	done
}

show_text() {
	echo -e "\tFELIZ NAVIDAD"
	sleep 1
	echo -e "\tMERRY CHRISTMAS"
	sleep 1
	echo -e "\tFROHE WEIHNACHTEN"
}

start_animation() {
	local frames=24 # Number of iterations to display the animation
	local height="$1"

	for ((i=1; i<=frames;i++)); do
		clear

		draw_tree "$height"
		echo -e "\n\n\n"
		sleep 1

		show_text
		sleep 3
	done
}

validate_height_or_exit() {
	local height="$1"

	# Check if height is numeric	
	if [[ ! "$height" =~ ^[0-9]+$ ]]; then
		echo "Height must be numeric."
		exit 1
	fi

	# Check if height is within the allowed range
	if [ "$height" -lt 5 ]; then
		echo "Height cannot be lower than 5"
		exit 1
	elif [ "$height" -gt 30 ]; then
		echo "Height cannot be greater than 30"
		exit 1
	fi
}

echo "Height of the tree:"
read -r height

validate_height_or_exit "$height"

mpg123 -q christmas-song.mp3 & # start music
MUSIC_PID=$!

start_animation "$height"

kill "$MUSIC_PID" # end music

