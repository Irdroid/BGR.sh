#!/bin/bash

##############################################################################
#									     # 
# BGR - Българско радио - Bash Плеър					     #
#									     #
# Автор  - Георги Бакалски, 2022г.					     #
# Лиценз - GNU General Public License 2.0				     #
# Версия - 0.1а								     #
#									     #
# Зависи от програмата ffplay от ffmpeg пакета				     #
# за Debian базирани дистрибуции sudo apt install ffmpeg		     #
#									     #
##############################################################################

clear

# Текущ стрийм
CURRENT=""

# Промпт за избор
PS3="Избери Радио:"

# Цветове / Българско знаме
RED='\033[41m'         # Red
Green='\033[42m'       # Green
White='\033[47m'       # White


STATIONS_LIST+="Energy "
STATIONS_LIST+="FM+ "
STATIONS_LIST+="Nova "
STATIONS_LIST+="Radio1 "
STATIONS_LIST+="Radio1Rock "
STATIONS_LIST+="BGRadio "
STATIONS_LIST+="Thevoice "
STATIONS_LIST+="ZRock "
STATIONS_LIST+="Njoy "
STATIONS_LIST+="City "
STATIONS_LIST+="Изход "

# URL адреси
URL_LIST+='https://playerservices.streamtheworld.com/api/livestream-redirect/RADIO_ENERGYAAC_H.aac ' 
URL_LIST+='http://193.108.24.21:8000/fmplus '
URL_LIST+='https://playerservices.streamtheworld.com/api/livestream-redirect/RADIO_NOVAAAC_H.aac '
URL_LIST+='https://playerservices.streamtheworld.com/api/livestream-redirect/RADIO_1AAC_H.aac '
URL_LIST+='https://playerservices.streamtheworld.com/api/livestream-redirect/RADIO_1_ROCKAAC_H.aac '
URL_LIST+='https://playerservices.streamtheworld.com/api/livestream-redirect/BG_RADIOAAC_H.aac '
URL_LIST+='https://bss1.neterra.tv/thevoicefm/thevoicefm.m3u8 '
URL_LIST+='http://193.108.24.6:8000/zrock '
URL_LIST+='http://46.10.150.243:80/njoy.mp3 '
URL_LIST+='http://149.13.0.80/city64 '
#read -r -d '' URL_LIST << EOM

#	https://playerservices.streamtheworld.com/api/livestream-redirect/RADIO_ENERGYAAC_H.aac # Energy
#	http://193.108.24.21:8000/fmplus	# FMPLUS
#	https://playerservices.streamtheworld.com/api/livestream-redirect/RADIO_NOVAAAC_H.aac # NOVA

#EOM



##############################################################################
# Функцията "spinner" се използва за показване на прогрес, действие което се # 
# случва на заден фон.							     # 
##############################################################################

spinner () {
    local chars=('|' / - '\')

        # hide the cursor
            tput civis
            trap 'printf "\010"; tput cvvis; return' INT TERM

            printf %s "$*"

             while :; do
               for i in {0..3}; do
                  printf %s "${chars[i]}"
                  sleep 0.3
                  printf '\010'
               done
          done
 }

##############################################################################
# Тази фунция се ползва за получаването и изписване на екрана на името на    #
# текущата песен ( само за онлайн радио станциите които се поддържат )       #
##############################################################################

getsong () {
	case $1 in
	Energy)
		set -- $URL_LIST
		ffprobe -hide_banner $1  |& grep "StreamTitle"
		set -- $STATIONS_LIST 
 		;;
	FM+)
		set -- $URL_LIST
		ffprobe -hide_banner $2  |& grep "StreamTitle"
		set -- $STATIONS_LIST
		;;
	esac
 }

###############################################################################
# Избор на радиостанция от списък с налични				      #
###############################################################################

function Select()
{

select station in $STATIONS_LIST

	do

	  case $station in

		Energy)
			Play "Energy"
			break;; 
		FM+)
			Play "FM+"
			break
		;;
	 	Nova)
	 		Play "Nova"
	 		break
	 	;;
	 	Radio1)
	 		Play "Radio1"
	 		break
	 	;;
	 	Radio1Rock)
                        Play "Radio1Rock"
                        break
                ;;
                BGRadio)
                        Play "BGRadio"
                        break
                ;;
                Thevoice)
                        Play "Thevoice"
                        break
                ;;
                ZRock)
                        Play "ZRock"
                        break
                ;;
                Njoy)
                        Play "Njoy"
                        break
                ;;
                City)
                	Play "City"
                	break
                ;;
	 	Изход)
	 		clear
			exit;;
	  esac	

	  REPLY=""
	
	done

}

function PRINTNAME()
{
 printf "$White \033[0m$Green \033[0m$RED \033[0m BGR Плеър за Българско Internet радио"
 echo;
}

function PRINTINTRO()
{
 printf "    Плеър за Българско Internet радио"
 echo;
}

################################################################################
# Тази фунция се вика след направен избор на радиостанция и служи за свързване #
# и плейбек на избраната радиостанция от предишната функция		       #
################################################################################

function Play()
{
clear
printf  "$White \033[0m$Green \033[0m$RED \033[0m \033[104mРадио: $1 \033[0m \n"
#echo $1
#echo $CURRENT
arguments=("$@")

local pid return
if [ "$1"  != "$CURRENT" ]; 

then
	case $1 in
	  Energy)
	  	killall ffplay &> /dev/null
		set -- $URL_LIST
		ffplay -nodisp -hide_banner $1 &> /dev/null &
		set -- $arguments
		;;
	  FM+)
	  	killall ffplay &> /dev/null
	  	set -- $URL_LIST
	  	ffplay -nodisp -hide_banner $2 &> /dev/null &
		set -- $arguments 
		;;

	  Nova)
	  	killall ffplay &> /dev/null
	  	set -- $URL_LIST
	  	ffplay -nodisp -hide_banner $3 &> /dev/null &
	 	set -- $arguments
	  	;;
	  Radio1)
	  	killall ffplay &> /dev/null
                set -- $URL_LIST
                ffplay -nodisp -hide_banner $4 &> /dev/null &
                set -- $arguments
		;;
          Radio1Rock)
                killall ffplay &> /dev/null
                set -- $URL_LIST
                ffplay -nodisp -hide_banner $5 &> /dev/null &
                set -- $arguments
                ;;
          BGRadio)
                killall ffplay &> /dev/null
                set -- $URL_LIST
                ffplay -nodisp -hide_banner $6 &> /dev/null &
                set -- $arguments
                ;;
          Thevoice)
                killall ffplay &> /dev/null
                set -- $URL_LIST
                ffplay -nodisp -hide_banner $7 &> /dev/null &
                set -- $arguments
                ;;
           ZRock)
                killall ffplay &> /dev/null
                set -- $URL_LIST
                ffplay -nodisp -hide_banner $8 &> /dev/null &
                set -- $arguments
                ;;
           Njoy)
                killall ffplay &> /dev/null
                set -- $URL_LIST
                ffplay -nodisp -hide_banner $9 &> /dev/null &
                set -- $arguments
                ;;
           City)
                killall ffplay &> /dev/null
                set -- $URL_LIST
                ffplay -nodisp -hide_banner "${10}" &> /dev/null &
                set -- $arguments
                ;;
	esac  
fi

CURRENT=$1
# ffprobe -hide_banner https://playerservices.streamtheworld.com/api/livestream-redirect/RADIO_ENERGYAAC_H.aac  |& grep  "StreamTitle"
spinner 'Playing > ' & pid=$!
# ffprobe -hide_banner https://playerservices.streamtheworld.com/api/livestream-redirect/RADIO_ENERGYAAC_H.aac  |& grep  "StreamTitle"
#echo -e "\e[?16;0;200c"
echo "b - Назад | q - Изход"
echo "" 
	while read -n 1 command;
 		do
			case $command in
				b)
					clear
					kill "$pid"
					wait "$pid"		
					PRINTNAME
					echo;
					Select
					exit;;
				q)
					kill "$pid"
					wait "$pid"
					clear
					printf "\nИзход без спиране на стрийма! \n"
					printf "за спиране - killall ffplay \n"
					exit;;

				t)
					clear
					kill "$pid"
					wait "$pid"	
					getsong $CURRENT
					sleep 3
					Play $CURRENT
					;;
				s)
					killall ffplay
					clear
                                        kill "$pid"
                                        wait "$pid"
                                        PRINTNAME
                                        echo;
                                        Select
                                        exit;;
					
		
			esac

done
}

if ! command -v ffplay &> /dev/null
then
    echo "ffplay не е намерен,моля инсталирай - sudo apt install ffmpeg"
    exit
fi

cat <<EOF
 ____   _____ _____            _
|  _ \ / ____|  __ \          | |
| |_) | |  __| |__) |      ___| |___
|  _ <| | |_ |  _  /      / __| |_  |
| |_) | |__| | | \ \   _  \__ \ | | |
|____/ \_____|_|  \_\ (_) |___/_| |_|
EOF
        PRINTINTRO
        echo;
        Select
