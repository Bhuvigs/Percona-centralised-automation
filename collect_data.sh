#!/bin/bash

set -e

# ----------------------------
# Install Go if not installed
# ----------------------------
if ! command -v go &> /dev/null; then

    GO_VERSION="1.23.8"
    GO_TAR="go${GO_VERSION}.linux-amd64.tar.gz"
    GO_URL="https://go.dev/dl/${GO_TAR}"
    GO_INSTALL_DIR="/usr/local"

    curl -LO "$GO_URL"
    sudo rm -rf ${GO_INSTALL_DIR}/go
    sudo tar -C $GO_INSTALL_DIR -xzf $GO_TAR
    rm -f $GO_TAR

    echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee -a /etc/profile
    source /etc/profile
fi

# ----------------------------
# Install Gum if not installed
# ----------------------------
if ! command -v gum &> /dev/null; then
    go install github.com/charmbracelet/gum@latest
    echo 'export PATH=$PATH:/root/go/bin' | sudo tee -a /etc/profile
    source /etc/profile
fi

# ----------------------------
# Ensure sysstat (mpstat) is installed
# ----------------------------
if ! command -v mpstat &> /dev/null; then
    sudo dnf install -y sysstat
fi

# ----------------------------
# Start TUI Monitor Loop
# ----------------------------
while true; do
    CHOICE=$(gum choose "CPU Utilization" "Memory Utilization" "Disk Utilization" "Network Utilization" "Exit")

    case $CHOICE in 
        "CPU Utilization")
            CPU_USAGE=$(mpstat 1 1 | awk '/all/ {print 100 - $NF "%"}' | head -n 1)
            gum style --border "rounded" --foreground 255 --background 27 --border-foreground 27 --align center --width 50 --margin "1 2" --padding "2 4" "CPU Usage: $CPU_USAGE"
            ;;
        "Memory Utilization")
            MEM_USAGE=$(free -m | awk '/Mem:/ {print $3 "MB / " $2 "MB (" int($3*100/$2) "%)"}')
            gum style --border "rounded" --foreground 255 --background 28 --border-foreground 28 --align center --width 50 --margin "1 2" --padding "2 4" "Memory Usage: $MEM_USAGE"
            ;;
        "Disk Utilization")
            DISK_USAGE=$(df -h | awk '$NF=="/" {print $3 " / " $2 " (" $5 ")"}')
            gum style --border "rounded" --foreground 255 --background 124 --border-foreground 124 --align center --width 50 --margin "1 2" --padding "2 4" "Disk Usage: $DISK_USAGE"
            ;;
        "Network Utilization")
            INTERFACE=$(ip route | grep default | awk '{print $5}')
            RX1=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
            TX1=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)
            sleep 1
            RX2=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
            TX2=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)
            DOWNLOAD=$(( (RX2 - RX1) / 1024 ))
            UPLOAD=$(( (TX2 - TX1) / 1024 ))
            gum style --border "rounded" --foreground 255 --background 33 --border-foreground 33 --align center --width 50 --margin "1 2" --padding "2 4" "Download: $DOWNLOAD KB/s | Upload: $UPLOAD KB/s"
            ;;
        "Exit")
            gum style --border "rounded" --foreground 255 --background 160 --border-foreground 160 --align center --width 50 --margin "1 2" --padding "2 4" "Exiting..."
            exit 0
            ;;
        *)
            gum style --border "rounded" --foreground 255 --background 214 --border-foreground 214 --align center --width 50 --margin "1 2" --padding "2 4" "Invalid selection"
            ;;
    esac
done

