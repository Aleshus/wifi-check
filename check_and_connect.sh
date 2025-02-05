#!/bin/bash

# Path to the configuration file
CONFIG_FILE="/etc/wifi_config.conf"

# Load configuration
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "Error: Configuration file $CONFIG_FILE not found."
    exit 1
fi

# Ensure required variables are set
if [ -z "$INTERFACE" ] || [ -z "$SSID" ] || [ -z "$IP_ADDRESS" ] || [ -z "$NETMASK" ] || [ -z "$CHECK_INTERVAL" ]; then
    echo "Error: Missing required configuration variables in $CONFIG_FILE."
    exit 1
fi

# Function to connect to the Wi-Fi network
connect_to_wifi() {
    echo "Connecting to WiFi network $SSID on interface $INTERFACE..."

    # Bring the interface up
    sudo ip link set "$INTERFACE" up

    # Connect to the SSID using `iw`
    sudo iw dev "$INTERFACE" connect "$SSID"

    # Assign IP address manually
    sudo ip addr add "$IP_ADDRESS/$NETMASK" dev "$INTERFACE"

    echo "Connected to $SSID and IP address configured."
}

# Function to check if already connected
check_connection() {
    # Get the currently associated SSID
    CURRENT_SSID=$(iw dev "$INTERFACE" link | grep 'SSID' | awk '{print $2}')

    if [ "$CURRENT_SSID" != "$SSID" ]; then
        echo "Not connected to $SSID (Currently connected to: $CURRENT_SSID)."
        return 1
    else
        echo "Already connected to $SSID."
        return 0
    fi
}

# Periodically check connection status and reconnect if needed
while true; do
    if ! check_connection; then
        connect_to_wifi
    fi
    sleep "$CHECK_INTERVAL"
done