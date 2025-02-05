# WiFi-Check

WiFi-Check is a lightweight bash script designed to ensure that a designated wireless interface remains connected to a specified WiFi network. If the connection is lost, the script automatically reconnects and assigns a static IP address to the interface. This is accompanied by a systemd service for easy deployment and management.

## Features

- Periodically checks the connection to a WiFi network.
- Automatically reconnects if the connection is lost.
- Allows you to configure the wireless interface, SSID, static IP address, and other options through a simple configuration file.
- Easy integration with systemd for automatic startup and management.

---

## Installation

### 1. Install the Package

Build and install the package using `makepkg` or your preferred AUR helper:

```bash
makepkg -si
```

This will install the following:

- **Script**: `/usr/local/bin/check_and_connect.sh`
- **Configuration File**: `/etc/wifi_config.conf`
- **Systemd Service**: `/usr/lib/systemd/system/wifi-check.service`

---

## Configuration

Before starting the service, edit the configuration file at `/etc/wifi_config.conf` with proper settings for your network.

### Example Configuration File (`/etc/wifi_config.conf`)

```bash
# WiFi Configuration

# Wireless interface name (e.g., wlan0, usb0)
INTERFACE="wlan0"

# WiFi SSID to connect to
SSID="example-ssid"

# Static IP address and subnet mask
IP_ADDRESS="192.168.0.50"
NETMASK="255.255.255.0"

# Interval (in seconds) to check the WiFi connection
CHECK_INTERVAL=30
```

| **Variable**         | **Description**                                          |
|-----------------------|----------------------------------------------------------|
| `INTERFACE`          | The name of the wireless network interface (e.g., `wlan0`, `usb0`). |
| `SSID`               | The name of the WiFi network (SSID) to connect to.        |
| `IP_ADDRESS`         | The static IP address to assign to the interface.         |
| `NETMASK`            | The subnet mask for the interface.                        |
| `CHECK_INTERVAL`     | The time (in seconds) between connection checks.          |

---

## Usage

### 1. Enable the Systemd Service

To start the script automatically at boot, enable the systemd service:

```bash
sudo systemctl enable wifi-check
```

### 2. Start the Service

Start the service manually or reboot to see it in action:

```bash
sudo systemctl start wifi-check
```

### 3. Monitor the Service

Check the logs to ensure the service is running properly:

```bash
sudo journalctl -u wifi-check
```

---

## How It Works

1. The script (`check_and_connect.sh`):
    - Periodically checks if the specified wireless interface is connected to the correct WiFi network.
    - If the interface is not connected, the script:
        - Brings the interface up.
        - Connects to the specified WiFi SSID using the `iw` tool.
        - Assigns the configured static IP address and netmask manually using `ip`.

2. The configuration file (`/etc/wifi_config.conf`) stores all modifiable settings, such as the interface, SSID, and IP configuration.

3. The systemd service (`wifi-check.service`) ensures the script is executed as a systemd-managed process, making it easier to start, stop, or restart as needed.

---

## Uninstallation

If you need to uninstall `wifi-check`, perform the following steps:

1. Disable the systemd service:

```bash
sudo systemctl disable wifi-check
```

2. Remove any related files if you installed manually:

```bash
sudo rm /usr/local/bin/check_and_connect.sh
sudo rm /usr/lib/systemd/system/wifi-check.service
sudo rm /etc/wifi_config.conf
```

3. If installed using a package manager, remove it using:

```bash
sudo pacman -R wifi-check
```

---

## Troubleshooting

- **Cannot connect to WiFi**:
    - Ensure the `INTERFACE` and `SSID` in `/etc/wifi_config.conf` are correct.
    - Verify that your device supports the `iw` and `ip` tools by running them manually.

- **IP Address Conflict**:
    - Ensure the static IP address (`IP_ADDRESS`) does not conflict with other devices on your local network.

- **Service fails to start**:
    - Check the logs:
      ```bash
      sudo journalctl -xeu wifi-check
      ```
    - Verify the permissions and format of `/etc/wifi_config.conf`.

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

## Contributions

Contributions are welcome! If you have ideas for improvements or encounter bugs, feel free to open an issue or submit a pull request.

---

Enjoy automated management of your WiFi connection with **WiFi-Check**! 😊