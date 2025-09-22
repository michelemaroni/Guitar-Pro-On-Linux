desktop=$(xdg-user-dir DESKTOP)

if ! dpkg -s wine wine64 winetricks ttf-mscorefonts-installer winehq-stable &> /dev/null; then
    sudo apt install --install-recommends wine wine64 winetricks ttf-mscorefonts-installer winehq-stable
fi

if [ -d "~/wol/Guitar_Pro_8" ]; then
  read -p "The directory ~/wol/Guitar_Pro_8 already exists. Do you want to delete it? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf ~/wol/Guitar_Pro_8
  fi
else
    mkdir ~/wol/Guitar_Pro_8
    cp ~/wol/Downloads/Guitar_Pro_8/icon.png ~/wol/Downloads/Guitar_Pro_8/startup.sh ~/wol/Guitar_Pro_8
    cp ~/wol/Downloads/Guitar_Pro_8/guitarpro.desktop $desktop
fi


if [ ! -f "guitar-pro-8-setup.exe" ]; then
    echo "Downloading Guitar Pro 8..."
    wget https://download-fr-3.guitar-pro.com/gp8/stable/guitar-pro-8-setup.exe
else
  echo "File already exists, skipping download."
fi

echo "Preparing Wineprefix enviroment..."
WINEARCH=win64 WINEPREFIX=~/wol/Guitar_Pro_8/ winetricks win7
WINEARCH=win64 WINEPREFIX=~/wol/Guitar_Pro_8/ winetricks corefonts
echo "Installing Guitar Pro 8..."
WINEARCH=win64 WINEPREFIX=~/wol/Guitar_Pro_8/ wine guitar-pro-8-setup.exe
echo "The installer have finished to work!"
