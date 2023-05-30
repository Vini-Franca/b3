#!/bin/bash
#########################################################################################
# Obj: Criar imagem base para testes portaveis entre servidores utilizando Robot framework
tag=`date +%d%m%y%S`
#########################################################################################
GREEN="\e[1;32m"
DEFAULT="\e[0m"
RED="\e[1;31m"
YELLOW="\e[1;33m"
BLUE="\e[1;36m"

clear
echo -e "${GREEN}#### Image Builder/ Robot exec ##########${DEFAULT}"
if [ "$1" == "build" ]; then
        echo "${YELLOW}[+] Building image...${DEFAULT}"
	echo "${YELLOW}    Image name: yaman-robot:$tag${DEFAULT}"
        docker build -t yaman-robot:$tag .
elif [ -f $1 ] &&  echo $1 | grep .robot >/dev/null ; then
        echo "${YELLOW}[+] Running ROBOT test...${DEFAULT}"
        tag=`docker images yaman-robot| head  -2 | tail -1| cut -d " " -f4`
        docker run --rm -v $(pwd):/workspace:cached -w /workspace yaman-robot:$tag python3 -m robot $1
else
        echo -e "${RED}[+] Opção invalida..."
        echo "    Digite $0 <build>|<file.robot>${DEFAULT}"
fi
echo -e "${GREEN}#### Image Builder/ Robot exec ##########${DEFAULT}"

