#!/bin/bash
set -e

echo "🔧 Updating system and installing required packages..."
sudo pacman -Syu --noconfirm \
  gtk-engine-murrine gtk-engines \
  qt5ct qt6ct kvantum \
  xsettingsd lxappearance \
  xfce4-settings xfwm4 \
  dconf nwg-look git unzip \
  papirus-icon-theme

echo "🎨 Installing Colloid Catppuccin GTK Theme..."
git clone https://github.com/vinceliuice/Colloid-gtk-theme.git /tmp/Colloid-gtk-theme
cd /tmp/Colloid-gtk-theme
./install.sh -t catppuccin -c mocha -s standard -d ~/.themes

echo "🖱️ Installing Catppuccin cursors..."
git clone https://github.com/catppuccin/cursors.git /tmp/catppuccin-cursors
mkdir -p ~/.icons
cp -r /tmp/catppuccin-cursors/*Mocha*/ ~/.icons/Catppuccin-Mocha-Dark-Cursors

echo "⚙️ Setting environment variables for Qt apps..."
if ! grep -q "QT_QPA_PLATFORMTHEME" ~/.profile; then
  cat <<EOF >> ~/.profile

# Qt Theming
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_STYLE_OVERRIDE=kvantum
EOF
fi
source ~/.profile

echo "🧩 Applying GTK2/3/4, icon, and cursor themes..."
THEME="Colloid-Catppuccin-Mocha-Standard"
ICON="Papirus-Dark"
CURSOR="Catppuccin-Mocha-Dark-Cursors"
FONT="JetBrains Mono 10"

mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0

cat > ~/.config/gtk-3.0/settings.ini <<EOF
[Settings]
gtk-theme-name=$THEME
gtk-icon-theme-name=$ICON
gtk-cursor-theme-name=$CURSOR
gtk-font-name=$FONT
EOF

cat > ~/.config/gtk-4.0/settings.ini <<EOF
[Settings]
gtk-theme-name=$THEME
gtk-icon-theme-name=$ICON
gtk-cursor-theme-name=$CURSOR
gtk-font-name=$FONT
EOF

cat > ~/.gtkrc-2.0 <<EOF
gtk-theme-name="$THEME"
gtk-icon-theme-name="$ICON"
gtk-cursor-theme-name="$CURSOR"
gtk-font-name="$FONT"
EOF

echo "🪟 Setting XFWM4 theme if running..."
xfconf-query -c xfwm4 -p /general/theme -s "$THEME" || true

echo "🚀 Launching nwg-look..."
nwg-look &

echo "✅ Theme installation complete!"
rm -rf /tmp/Colloid-gtk-theme /tmp/catppuccin-cursors

