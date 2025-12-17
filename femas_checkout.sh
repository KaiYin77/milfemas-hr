#!/bin/bash

####################################
# Femas Cloud Daily Check-out Script
####################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/femas_common.sh"

main() {
    local action="check-out"
    local color_icon="🔴"

    load_env
    check_holiday "$action"
    random_delay "$action" "$color_icon"
    login "$color_icon"
    get_user_id "$color_icon"

    perform_clock_listing "$color_icon" "E"
    perform_revision_save "$color_icon" "Users%2Fatt_status_listing"
    verify_status "$color_icon"

    logout "$color_icon"

    echo "$(date) | $color_icon Check-out script finished"
}

main "$@"
