#!/usr/bin/env fish
# mac-narrator — your Mac's inner monologue, powered by Apple Intelligence
#
# One-shot:  mac-narrator
# Watch:     mac-narrator --watch
#            mac-narrator --watch --interval 30
#
# Requires: apfel installed (https://github.com/Arthur-Ficial/apfel)

function mac-narrator
set INTERVAL 60
set WATCH false

while set -q argv[1]
    switch $argv[1]
        case --watch -w
            set WATCH true
            set -e argv[1]
        case --interval -i
            set INTERVAL $argv[2]
            set -e argv[1]
            set -e argv[1]
        case -h --help
            echo "mac-narrator — your Mac's inner monologue"
            echo ""
            echo "Usage: mac-narrator [--watch [--interval N]]"
            echo ""
            echo "  --watch, -w        Continuous mode (default: every 60s)"
            echo "  --interval N, -i N  Seconds between narrations"
            echo ""
            echo "Requires: apfel (Apple Intelligence CLI)"
            exit 0
        case '*'
            echo "Unknown option: $argv[1]. Use --help."
            exit 1
    end
end

if not command -q apfel
    echo "Error: apfel not found. Install from https://github.com/Arthur-Ficial/apfel"
    exit 1
end

set PROMPT "You narrate this computer's life like a nature documentary. Given system data, respond with EXACTLY 1-2 short sentences. Be specific about process names and numbers. Dry British humor. No bullet points, no lists."

function narrate
    set snapshot (
        ps -eo pid,%cpu,%mem,comm -r 2>/dev/null | head -8
        echo "---"
        memory_pressure 2>/dev/null | head -3
        echo "---"
        df -h / 2>/dev/null | tail -1
        echo "---"
        pmset -g batt 2>/dev/null | tail -1
        echo "---"
        uptime 2>/dev/null
    )

    set oneline (echo "$snapshot" | tr '\n' '; ')

    begin
        set -lx LC_ALL en_US.UTF-8
        set comment (apfel -q --max-tokens 150 -s "$PROMPT" "System snapshot: $oneline")
    end
    if test $status -eq 0
        echo -e "\033[90m["(date +%H:%M:%S)"]\033[0m $comment"
    else
        echo -e "\033[90m["(date +%H:%M:%S)"]\033[0m \033[33m(model busy, skipping)\033[0m"
    end
end

if test "$WATCH" = true
    echo -e "\033[36m🍎 mac-narrator\033[0m watching every "$INTERVAL"s (Ctrl+C to stop)"
    echo ""
    while true
        narrate
        echo ""
        sleep "$INTERVAL"
    end
else
    narrate
end
end
