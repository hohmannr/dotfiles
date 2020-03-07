#!/usr/bin/env python3
# coding=utf8

import sys
import os

def take_screenshot(window=False):
    os.system("aplay ~/.sounds/camera-shutter.wav")

    if window:
        os.system("scrot -u 'window_%s-%H-%M_%d.%m.%Y_$wx$h.png' -e 'mv $f ~/Pictures/Screenshots'")
    else:
        os.system("scrot 'screen_%s-%H-%M_%d.%m.%Y_$wx$h.png' -e 'mv $f ~/Pictures/Screenshots'")

if __name__ == "__main__":
    if "-w" in sys.argv:
        take_screenshot(window=True)
    else:
        take_screenshot()
    
