#!/bin/bash

####################################
# Femas Cloud Daily Check-in Script
####################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/femas_common.sh"

main() {
    local action="check-in"
    local color_icon="🟢"

    load_env
    check_holiday "$action"
    random_delay "$action" "$color_icon"
    login "$color_icon"
    get_user_id "$color_icon"

    perform_clock_listing "$color_icon" "S"
    perform_revision_save "$color_icon" "users%2Fshow_time"
    verify_status "$color_icon"

    logout "$color_icon"

    echo "$(date) | $color_icon Check-in script finished"
}

main "$@"