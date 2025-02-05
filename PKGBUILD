pkgname=wifi-check
pkgver=1.0
pkgrel=1
pkgdesc="WiFi Connection Checker that periodically ensures a wireless interface is connected and reconnects if needed."
arch=('any')
license=('MIT')
depends=('bash' 'iw' 'iproute2' 'systemd')
source=("check_and_connect.sh"
           "wifi-check.service"
           "wifi_config.conf")
install=${pkgname}.install
sha256sums=('SKIP'
            'SKIP'
            'SKIP')



package() {
    # Install the script to /usr/local/bin/
    install -Dm755 "$srcdir/check_and_connect.sh" "$pkgdir/usr/local/bin/check_and_connect.sh"

    # Install the systemd service file
    install -Dm644 "$srcdir/wifi-check.service" "$pkgdir/usr/lib/systemd/system/wifi-check.service"

    # Install the configuration file to /etc/
    install -Dm644 "$srcdir/wifi_config.conf" "$pkgdir/etc/wifi_config.conf"
}
