#!/bin/bash
set -e
cc main.m -o MacRez.app/Contents/MacOS/MacRez -framework Cocoa
echo Build succeeded.
MacRez.app/Contents/MacOS/MacRez
