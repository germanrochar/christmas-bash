#!/usr/bin/env bash
# Copyright (C) 2025 Germán Rocha
# SPDX-License-Identifier: GPL-3.0-or-later


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
				echo -n -e "\e[33m*\e[0m"
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
		for ((j = 0; j < 20; j++)); do
		       echo -n " "	
	       done

	       echo "|"
	done

	echo -e "\n\n\n"

	sleep 1

	echo "             FELIZ NAVIDAD"
	sleep 1
	echo "             MERRY CHRISTMAS"
	sleep 1
	echo "             FROHE WEIHNACHTEN"
	sleep 3
}

animate() {
	local frames="$1"
	local height="$2"

	for ((i=1; i<=frames;i++)); do
		clear
		draw_tree "$height"
		sleep 35
	done
}

mpg123 -q christmas-song.mp3 & # start music
MUSIC_PID=$!

animate 20 21

kill "$MUSIC_PID" # end music
