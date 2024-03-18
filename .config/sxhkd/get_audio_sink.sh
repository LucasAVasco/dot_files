#!/bin/sh


# Get audio sink, select only the RUNNING
# Get the first column with the number (cut -f1), and print the first number (sed -n '1p')
pactl list short sinks | grep RUNNING | cut -f1 | sed -n '1p'
