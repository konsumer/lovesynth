#!/bin/sh

# this starts the synth

# on mac: brew install fluid-synth
# on debian: apt install fluidsynth

# https://fluid-dev.nongnu.narkive.com/ovSZ8tNW/how-to-send-manual-midi-commands-to-fluidsynth-from-another-program

fluidsynth -i -s -o "shell.port=9988"
