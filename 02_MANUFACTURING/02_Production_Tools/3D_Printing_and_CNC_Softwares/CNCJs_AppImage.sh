#!/bin/sh
    
########################################################################
# VISIT: 
# SCRIPT CREDITS: https://portable-linux-apps.github.io
# 
# USAGE:
#  Make it executable:
#   $ sudo chmod +x ~/Downloads/CNCJs_AppImage.sh
#  Then run
#   $ sudo bash ~/Downloads/CNCJs_AppImage.sh
########################################################################


APP=cncjs
REPO="cncjs/cncjs"

# CREATE THE FOLDER
mkdir /opt/$APP
cd /opt/$APP

# ADD THE REMOVER
echo '#!/bin/sh' >> /opt/$APP/remove
echo "rm -R -f /usr/share/applications/AM-$APP.desktop /opt/$APP /usr/local/bin/$APP" >> /opt/$APP/remove
chmod a+x /opt/$APP/remove

# DOWNLOAD THE ARCHIVE
mkdir tmp
cd ./tmp

version=$(wget -q https://api.github.com/repos/$REPO/releases -O - | grep -w -v i386 | grep -w -v i686 | grep -w -v arm64 | grep -w -v armv7l | grep browser_download_url | grep -i appimage | cut -d '"' -f 4 | head -1)
wget $version
echo "$version" >> /opt/$APP/version
cd ..
mv ./tmp/*mage ./$APP
chmod a+x /opt/$APP/$APP
rmdir ./tmp

# LINK
ln -s /opt/$APP/$APP /usr/local/bin/$APP

# SCRIPT TO UPDATE THE PROGRAM
cat >> /opt/$APP/AM-updater << 'EOF'
#!/usr/bin/env bash
APP=cncjs
REPO="cncjs/cncjs"
version0=$(cat /opt/$APP/version)
version=$(wget -q https://api.github.com/repos/$REPO/releases -O - | grep -w -v i386 | grep -w -v i686 | grep -w -v arm64 | grep -w -v armv7l | grep browser_download_url | grep -i appimage | cut -d '"' -f 4 | head -1)
if [ $version = $version0 ]; then
  echo "Update not needed!"
else
  notify-send "A new version of $APP is available, please wait"
  mkdir /opt/$APP/tmp
  cd /opt/$APP/tmp
  wget $version
  if ls . | grep mage; then
	cd ..
  	if test -f ./tmp/*mage; then rm ./version
  	fi
  	echo $version >> ./version
  	mv --backup=t ./tmp/*mage ./$APP
  	chmod a+x /opt/$APP/$APP
  	rm -R -f ./tmp ./*~
  fi
  notify-send "$APP is updated!"
fi
EOF
chmod a+x /opt/$APP/AM-updater

# LAUNCHER & ICON
app=$(echo $APP | cut -c -3)
cd /opt/$APP
./$APP --appimage-extract *.desktop 1>/dev/null
./$APP --appimage-extract share/applications/*.desktop 1>/dev/null
./$APP --appimage-extract usr/share/applications/*.desktop 1>/dev/null
mv squashfs-root/*.desktop ./$APP.desktop
mv squashfs-root/share/applications/*.desktop ./$APP.desktop
mv squashfs-root/usr/share/applications/*.desktop ./$APP.desktop
if [ ! -e ./$APP.desktop ]; then 
	rm ./$APP.desktop; ./$APP --appimage-extract usr/share/applications/*$app*.desktop 
	mv squashfs-root/usr/share/applications/*.desktop ./$APP.desktop
fi
if [ ! -e ./$APP.desktop ]; then 
	rm ./$APP.desktop; ./$APP --appimage-extract share/applications/*$app*.desktop 1>/dev/null
	mv squashfs-root/share/applications/*.desktop ./$APP.desktop
fi
CHANGEEXEC=$(cat ./$APP.desktop | grep Exec= | tr ' ' '\n' | tr '=' '\n' | tr '/' '\n' | grep $app | head -1)
sed -i "s#$CHANGEEXEC#$APP#g" ./$APP.desktop
sed -i "s#AppRun#$APP#g" ./$APP.desktop
sed -i "s#Exec=/bin/#Exec=#g" ./$APP.desktop
sed -i "s#Exec=/usr/bin/#Exec=#g" ./$APP.desktop
CHANGEICON=$(cat ./$APP.desktop | grep Icon= | head -1)
sed -i "s#$CHANGEICON#Icon=/opt/$APP/icons/$APP#g" ./$APP.desktop

mkdir icons
mv $(./$APP --appimage-extract *.png) ./icons/$APP 2>/dev/null
mv $(./$APP --appimage-extract *.svg) ./icons/$APP 2>/dev/null
./$APP --appimage-extract share/icons/*/*/* 1>/dev/null
./$APP --appimage-extract usr/share/icons/*/*/* 1>/dev/null
./$APP --appimage-extract share/icons/*/*/*/* 1>/dev/null
./$APP --appimage-extract usr/share/icons/*/*/*/* 1>/dev/null
mv ./squashfs-root/share/icons/hicolor/22x22/apps/*$app* ./icons/$APP 2>/dev/null
mv ./squashfs-root/share/icons/hicolor/24x24/apps/*$app* ./icons/$APP 2>/dev/null
mv ./squashfs-root/share/icons/hicolor/32x32/apps/*$app* ./icons/$APP 2>/dev/null
mv ./squashfs-root/share/icons/hicolor/48x48/apps/*$app* ./icons/$APP 2>/dev/null
mv ./squashfs-root/share/icons/hicolor/64x64/apps/*$app* ./icons/$APP 2>/dev/null
mv ./squashfs-root/share/icons/hicolor/128x128/apps/*$app* ./icons/$APP 2>/dev/null
mv ./squashfs-root/share/icons/hicolor/256x256/apps/*$app* ./icons/$APP 2>/dev/null
mv ./squashfs-root/share/icons/hicolor/512x512/apps/*$app* ./icons/$APP 2>/dev/null
mv ./squashfs-root/share/icons/hicolor/scalable/apps/*$app* ./icons/$APP 2>/dev/null
mv ./squashfs-root/usr/share/icons/hicolor/22x22/apps/*$app* ./icons/$APP 2>/dev/null
mv ./squashfs-root/usr/share/icons/hicolor/24x24/apps/*$app* ./icons/$APP 2>/dev/null
mv ./squashfs-root/usr/share/icons/hicolor/32x32/apps/*$app* ./icons/$APP 2>/dev/null
mv ./squashfs-root/usr/share/icons/hicolor/48x48/apps/*$app* ./icons/$APP 2>/dev/null
mv ./squashfs-root/usr/share/icons/hicolor/64x64/apps/*$app* ./icons/$APP 2>/dev/null
mv ./squashfs-root/usr/share/icons/hicolor/128x128/apps/*$app* ./icons/$APP 2>/dev/null
mv ./squashfs-root/usr/share/icons/hicolor/256x256/apps/*$app* ./icons/$APP 2>/dev/null
mv ./squashfs-root/usr/share/icons/hicolor/512x512/apps/*$app* ./icons/$APP 2>/dev/null
mv ./squashfs-root/usr/share/icons/hicolor/scalable/apps/*$app* ./icons/$APP 2>/dev/null

rm -R -f /opt/$APP/squashfs-root
mv ./$APP.desktop /usr/share/applications/AM-$APP.desktop

# CHANGE THE PERMISSIONS
currentuser=$(who | awk '{print $1}')
chown -R $currentuser /opt/$APP

# MESSAGE
echo "
 $APP is provided by https://github.com/$(echo $REPO | sed 's:/[^/]*$::')
"
