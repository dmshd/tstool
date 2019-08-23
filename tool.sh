#!/bin/bash
# Docker localteleservices
## faciliter l'utilisation de sass 
## options de ligne de commande quand on execute le script
### visual feedbacks
bold=$(tput bold)
normal=$(tput sgr0)
er="❗ "
ok="✅ "
### feedbacks
msgOutil="🛠️  Outil local_téléservices >"
listeOptions='\n   Les options sont : \n      🔥  -s ou --save + nomcommune \n      🔥  -r nom ou --restore + nomcommune \n      🔥  -i sass ou --install sass \n      🔥  -S ou --switch nomcommune \n'
eropt="$msgOutil $er Je ne reconnais pas cette option."
ernoopt=""
erarg="$msgOutil $er Il manque un argument."
## si option on boucle
if [ "$1" != "" ]; then
  case $1 in 
    -s | --save )
      # si il y a un argument
      if [ ! -z $2 ]; then
        # si l'argument correspond à un dossier existant
        if [ -e /usr/share/publik/themes/imio/static/$2 ]; then
          # si je trouve la ou les occurences dans nomcommune/style.scss
          if grep --quiet -r "@import '../../../publik-base/static/includes/publik';" /usr/share/publik/themes/imio/static/$2/style.scss; then
            echo "$ok 📄  $2/styles.scss | Je change les occurences '${bold}../../../publik-base/static/includes/publik${normal}' en '${bold}../../publik-base-theme/static/includes/publik${normal}'"
            # je remplace globalement l'occurence
            sed -i "s|../../../publik-base/|../../publik-base-theme/|g" /usr/share/publik/themes/imio/static/$2/style.scss
            # cool UX
            sleep 0.6
          fi
          # je copie recursivement le dossier nomcommune situé dans /usr/... vers celui situé dans /opt/...
          echo "$ok Je copie 📂 ${bold}/usr${normal}/share/publik/themes/imio/static/${bold}$2 ${normal}  vers 📂 ${bold}/opt${normal}/publik/scripts/imio-publik-themes/static/ "
          cp -ru /usr/share/publik/themes/imio/static/$2 /opt/publik/scripts/imio-publik-themes/static/
          # cool UX
          sleep 0.6
        # sinon je notifie que l'argument ne correspond à aucun dossier dans static/
        else
          echo "$msgOutil $er ${bold}/usr${normal}/share/publik/themes/imio/static/${bold}$2 ${normal} n'existe pas"
        fi
      # sinon j'invite à entrer un argument
      else
        echo $erarg
      fi
      ;;
    -r | --restore )
      if [ ! -z $2 ]; then
        if [ -e /opt/publik/scripts/imio-publik-themes/static/$2 ]; then
          echo "$ok Je copie 📂 ${bold}/opt${normal}/publik/scripts/imio-publik-themes/static/${bold}$2 ${normal} vers 📂 ${bold}/usr${normal}/share/publik/themes/imio/static/ "
          sleep 0.6
          cp -r /opt/publik/scripts/imio-publik-themes/static/$2 /usr/share/publik/themes/imio/static/
        else
          echo "$msgOutil $er 📂  ${bold}/opt${normal}/publik/scripts/imio-publik-themes/static/${bold}$2 ${normal} n'existe pas"
        fi
      else
        echo $erarg
      fi
      ;;
    -S | --switch )
     if [ ! -z $2 ]; then
      # si je trouve l'occurence
      if grep --quiet -r "@import '../../publik-base-theme/static/includes/publik';" /usr/share/publik/themes/imio/static/$2/style.scss; then
        # je modifie la ou les occurences et j'informe
        sed -i "s|../../publik-base-theme/|../../../publik-base/|g" /usr/share/publik/themes/imio/static/$2/style.scss
        echo "$ok ${bold}../../publik-base-theme/${normal} a été modifié en ${bold}../../../publik-base/${normal}  dans 📄  styles.scss"
        sleep 0.3
        # serait-ce utile de : prompt sass styles : y or n ?
        echo "$ok J'exécute '${bold}sass /usr/share/publik/themes/imio/static/$2/style.scss /usr/share/publik/themes/imio/static/$2/style.css${normal}'"
        sass /usr/share/publik/themes/imio/static/$2/style.scss /usr/share/publik/themes/imio/static/$2/style.css
      else 
        echo "je ne trouve pas l'occurence   @import '../../publik-base-theme/static/includes/publik';   dans  📂 /usr/share/publik/themes/imio/static/$2/style.scss "
      fi
     else 
       echo $erarg
     fi
     ;;
    -i | --install )
      if [ ! -z $2 ]; then
        if [ "$2" = "sass" ]; then
          apt-get install rubygems && apt-get install rubygems-integration && apt install ruby-sass
        else 
           echo "$msgOutil $er Pour le moment je sais uniquement installer sass."
        fi
      else
       echo "$erarg"
      fi
      ;;
    -h | --help )
      echo -e "$msgOutil $listeOptions "
      ;;
    #-ss | --sass )
    #  if [ ! -e style.scss ]
    #  then
    #    echo "$er Il n'y a pas de 📄 ${bold}style.scss${normal} dans 📂 ${bold}${PWD}${normal}"
    #  else 
    #    sass styles.scss style.css
    #  fi
    #  ;;
    * )
      echo $eropt
      ;;
  esac
else 
 echo "$msgOutil $er Entre une option (--help si tu as besoin d'aide)"
fi
