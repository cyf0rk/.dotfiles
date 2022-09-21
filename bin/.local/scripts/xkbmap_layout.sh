if type "setxkbmap"; then
    for l in $(setxkbmap -query | grep "layout:"); do
        case "$l" in
            "us") setxkbmap hr
                ;;
            "hr") setxkbmap us
                ;;
        esac
    done
else
    echo "setxkbmap doesn't work"
fi
