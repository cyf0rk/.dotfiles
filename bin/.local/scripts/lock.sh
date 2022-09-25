#!/bin/bash
pgrep i3lock || i3lock -n --color=#12131b --ignore-empty-password --show-failed-attempts
