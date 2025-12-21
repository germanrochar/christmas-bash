#!/usr/bin/env bash
# Copyright (C) 2025 Germán Rocha
# SPDX-License-Identifier: GPL-3.0-or-late


draw_tree() {
	local height="$1"
	stars=1
	spaces=$((height - 1))
	
	for ((i = 0; i < height; i++)); do
		for ((x = 0; x < spaces; x++)); do
			echo -n " ";
		done

		for ((y = 0; y < stars; y++)); do
			if [ "$y" -eq 0 ] && [ "$i" -eq 0 ]; then
				echo -n -e "\e[31m*\e[0m"
			else
				echo -n -e "\e[32m*\e[0m"
			fi
		done

		spaces=$((spaces - 1))
		stars=$((stars + 2))
	
		echo ""
	done

	# Trunk
	for ((i = 0; i < 7; i++)); do
		for ((j = 0; j < $((height - 1)); j++)); do
		       echo -n " "	
	       done

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
	local frames=200 # big number to show the tree until the song is over
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

echo "Height of the tree:"
read height

mpg123 -q christmas-song.mp3 & # start music
MUSIC_PID=$!

start_animation $height

kill "$MUSIC_PID" # end music
