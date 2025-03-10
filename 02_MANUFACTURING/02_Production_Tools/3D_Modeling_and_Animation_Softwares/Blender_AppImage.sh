#!/bin/sh
    
########################################################################
# VISIT: 
# SCRIPT CREDITS: https://portable-linux-apps.github.io
# 
# USAGE:
#  Make it executable:
#   $ sudo chmod +x ~/Downloads/Blender_AppImage.sh
#  Then run
#   $ sudo bash ~/Downloads/Blender_AppImage.sh
########################################################################


branch=stable
APP=blender
APPNAME="Blender"

# CREATE THE FOLDER
mkdir /opt/$APP
cd /opt/$APP

# ADD THE REMOVER
echo '#!/bin/sh' >> /opt/$APP/remove
echo "rm -R -f /usr/share/applications/AM-$APP.desktop /opt/$APP /usr/local/bin/$APP" >> /opt/$APP/remove
chmod a+x /opt/$APP/remove

# DOWNLOAD
mkdir tmp
cd ./tmp

url=https://builder.blender.org/download/daily/archive/
version=$(curl -Ls $url | tr '"' '\n' | grep "^https" | grep .tar.xz | grep -w -v sha256 | grep $branch | head -1)
wget $version
echo "$version" >> /opt/$APP/version
tar fx *.tar.xz
dir=$(ls . | grep -w -v *.tar.*)
cd ..
mv ./tmp/$(echo $dir)/* ./
rm -R -f ./tmp

# LINK
ln -s /opt/$APP/blender /usr/local/bin/$APP

# SCRIPT TO UPDATE THE PROGRAM
cat >> /opt/$APP/AM-updater << 'EOF'
#!/usr/bin/env bash
branch=DEVELOPMENTBRANCH
APP=blender
url=https://builder.blender.org/download/daily/archive/
version=$(curl -Ls $url | tr '"' '\n' | grep "^https" | grep .tar.xz | grep -w -v sha256 | grep $branch | head -1)
version0=$(cat /opt/$APP/version)
if [ $version0 = $version ]; then
  echo "Update not needed, exit!"
else
  notify-send "A new version of blender is available, please wait"
  mkdir /opt/$APP/tmp
  cd /opt/$APP/tmp
  wget $version
  tar fx *.tar.xz
  dir=$(ls . | grep -w -v *.tar.*)
  cd ..
  if test -f ./tmp/*.tar.xz; then rm ./version
  fi
  echo "$version" >> ./version
  mv --backup=t ./tmp/$(echo $dir)/* ./
  rm -R -f ./tmp ./*~
  notify-send "$APP is updated!"
fi
EOF
sed -i s/DEVELOPMENTBRANCH/$branch/g /opt/$APP/AM-updater
chmod a+x /opt/$APP/AM-updater

# ADD SCRIPT TO ROLLBACK
cat >> /opt/$APP/$APP-rollback << 'EOF'
#!/usr/bin/env bash
branch=DEVELOPMENTBRANCH
APP=BLENDEDITION
rm -f ./rollback-args ./AM-rollback
URL=https://builder.blender.org/download/daily/archive/
SITE=https://www.blender.org
printf "%s\n" $(curl -Ls $URL | grep -Eo "$url[a-zA-Z0-9./?=_%:-]+[+a-zA-Z0-9./?=_%:-]*" | grep .tar.xz | grep -w -v sha256 | grep $branch) >> "./rollback-args" &&
echo -e "-----------------------------------------------------------------------\nYou have chosen to roll back $APP.\nRollback will be done from $SITE\n-----------------------------------------------------------------------"
printf "Select a URL from this menu (read carefully) or press CTRL+C to abort:\n-----------------------------------------------------------------------\n"; sleep 1;
select d in $(cat "./rollback-args"); do test -n "$d" && break; echo ">>> Invalid Selection"; done
cp ./AM-updater ./AM-rollback
sed -i 's/version0/#version0/g' ./AM-rollback
sed -i '/show-progress/c\wget -q --show-progress '$d'' ./AM-rollback
./AM-rollback
rm -f ./version
echo $d >> ./version
rm -f ./rollback-args ./AM-rollback
echo -e "\nROLLBACK SUCCESSFUL!"
exit
EOF
sed -i s/DEVELOPMENTBRANCH/$branch/g /opt/$APP/$APP-rollback
sed -i s/BLENDEDITION/$APP/g /opt/$APP/$APP-rollback
chmod a+x /opt/$APP/$APP-rollback

# ICON
icon=$(ls /opt/$APP/ | grep .svg | head -1)

# LAUNCHER
rm -f /usr/share/applications/AM-$APP.desktop
echo "[Desktop Entry]
Name=$APPNAME
GenericName=3D modeler
GenericName[ar]=3D المنمذج ثلاثي الأبعاد
GenericName[ca]=Modelador 3D
GenericName[cs]=3D modelování
GenericName[da]=3D-modellering
GenericName[de]=3D-Modellierer
GenericName[el]=Μοντελοποιητής 3D
GenericName[es]=Modelador 3D
GenericName[et]=3D modelleerija
GenericName[fi]=3D-mallintaja
GenericName[fr]=Modeleur 3D
GenericName[gl]=Modelador 3D
GenericName[hu]=3D modellező
GenericName[it]=Modellatore 3D
GenericName[ja]=3D モデラー
GenericName[lt]=3D modeliavimas
GenericName[nb]=3D-modellering
GenericName[nl]=3D-modeller
GenericName[pl]=Modelowanie 3D
GenericName[pt_BR]=Modelador 3D
GenericName[ro]=Arhitect 3D
GenericName[ru]=Редактор 3D-моделей
GenericName[tr]=3D modelleyici
GenericName[uk]=Редактор 3D-моделей
GenericName[wa]=Modeleu 3D
GenericName[zh_CN]=3D 建模
GenericName[zh_TW]=3D 模型
Comment=3D modeling, animation, rendering and post-production
Comment[ar]=3D النمذجة، الرسوم المتحركة، والتجسيد، وما بعد الإنتاج
Comment[ast]=Modeláu 3D, animación, renderizáu y postproducción
Comment[eu]=3D modelatzea, animazioa, errendatzea eta post-produkzioa
Comment[be]=Праграма прасторавага мадэлявання, анімацыі, апрацоўкі відэа і давядзення відэапрадукцыі
Comment[bn]=ত্রিমাত্রিক মডেল, অ্যানিমেশন, রেন্ডারিং এবং পোস্ট-উৎপাদন
Comment[bs]=3D modeliranje, animacija, obrada i postprodukcija
Comment[bg]=3D моделиране, анимиране, рендиране и пост-продукция
Comment[ca]=Modelat 3D, animació, renderització i post-producció
Comment[ca@valencia]=Modelat 3D, animació, renderització i post-producció
Comment[crh]=3B modelleme, animasyon, işleme ve son üretim
Comment[cs]=3D modelování, animace, rederování a postprodukce
Comment[da]=3D-modellering, animation, rendering og efterbehandling
Comment[de]=3D-Modellierung, Animation, Rendering und Nachbearbeitung
Comment[nl]=3d-modelleren, animeren, renderen en post-productie
Comment[el]=Μοντελοποίηση 3D, κινούμενα σχέδια, αποτύπωση και οργάνωση διαδικασίας μετά-την-παραγωγή
Comment[eo]=3D-modelado, animacio, renderado kaj postproduktado
Comment[es]=Modelado 3D, animación, renderizado y post-producción
Comment[et]=Kolmemõõtmeline modelleerimine, animeerimine, esitlemine ja järeltöötlemine
Comment[fi]=3D-mallinnus, -animaatiot, -renderöinti ja -tuotanto
Comment[fr]=Modélisation 3D, animation, rendu et post-production
Comment[fr_CA]=Modélisation 3D, animation, rendu et post-production
Comment[gl]=Modelado 3D, animación, renderizado e postprodución
Comment[hu]=3D modellek és animációk létrehozása és szerkesztése
Comment[is]=Þrívíddarmódel, hreyfimyndir, myndgerð og frágangur myndskeiða
Comment[it]=Modellazione 3D, animazione, rendering e post-produzione
Comment[ja]=3Dモデリング、アニメーション、レンダリング、ポストプロダクションのツール
Comment[ko]=3D 모델링, 애니메이션, 렌더링과 포스트 프로덕션
Comment[lt]=3D modeliavimas, animacijų kūrimas, atvaizdavimas ir tobulinimas
Comment[lv]=3D modelēšana, animācija, renderēšana un pēcapstrāde
Comment[ms]=Pemodelan, animasi, penerapan dan post-produksi 3D
Comment[nb]=3D-modellering, animasjon, rendering og postproduksjon
Comment[oc]=Modelizacion 3D, animacion, rendut e post-produccion
Comment[pl]=Modelowanie 3D, animacja, renderowanie i postprodukcja
Comment[pt]=Modelação 3D, animação, renderização e pós-produção
Comment[pt_BR]=Modelagem 3D, animação, renderização e pós-produção
Comment[ro]=Modelare, animare, afișare și post-producție 3D
Comment[ru]=3D-моделирование, анимация, рендеринг и компоновка
Comment[sl]=3D modeliranje, animacija, izrisovanje in nadaljnje obdelovanje
Comment[sq]=Animacion i modeleve 3D, rregullim dhe më pas prodhim
Comment[sr]=3Д моделовање, анимација, исцртавање и постпродукција
Comment[sv]=3d-modellering, animering, rendering och efterbehandling
Comment[ta]=முப்பரிமாண ஒப்புருவாக்கம், அசைவூட்டம், காட்சியாக்கம் மற்றும் உருவாக்கத்துக்கு பிந்தைய செயல்பாடுகள்
Comment[tg]=Моделсозии 3D, аниматсия, пешниҳод ва истеҳсоли баъдӣ
Comment[tr]=3B modelleme, animasyon, işleme ve son üretim
Comment[uk]=Програма просторового моделювання, анімації, обробки відео та доведення відеопродуктів
Comment[vi]=Tạo hình mẫu 3D, hoạt họa, dựng hình và các công việc hậu kỳ
Comment[wa]=Modelaedje 3D, animåcion, rindou eyet après-produccion
Comment[zh_HK]=3D 模型、動畫、算圖和後製
Comment[zh_CN]=3D 建模、动画、渲染和后期制作
Comment[zh_TW]=3D 模型、動畫、算圖和後製
Keywords=3d;cg;modeling;animation;painting;sculpting;texturing;video editing;video tracking;rendering;render engine;cycles;game engine;python;
Exec=$APP %f
Icon=/opt/$APP/$(echo $icon)
Terminal=false
Type=Application
Categories=Graphics;3DGraphics;
MimeType=application/x-blender;" >> /usr/share/applications/AM-$APP.desktop

