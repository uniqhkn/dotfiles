#!/usr/bin/env bash

set -e

echo "======================================="
echo "         Arch Cleanup Script"
echo "======================================="

echo
echo "[1/4] Cleaning pacman cache..."
sudo paccache -rk1

echo
echo "[2/4] Cleaning yay cache..."
sudo yay -Sc --noconfirm >/dev/null

echo
echo "[3/4] Removing orphan packages..."

if orphans=$(sudo pacman -Qdtq 2>/dev/null); then
  if [[ -n "$orphans" ]]; then
    sudo pacman -Rns $orphans
  else
    echo "No orphan packages found."
  fi
else
  echo "No orphan packages found."
fi

echo
echo "[4/4] Cleaning journal..."
sudo journalctl --vacuum-time=7d

echo
echo "======================================="
echo "          Cleanup Completed!"
echo "======================================="

echo
echo "Disk usage:"
sudo df -h /

echo
echo "Pacman cache:"
sudo du -sh /var/cache/pacman/pkg

echo
echo "Yay cache:"
sudo du -sh ~/.cache/yay

echo
echo "Home directory:"
sudo du -sh ~
