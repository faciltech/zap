#!/bin/bash
	echo "Este programa faz uma extracao de dados de mensagens do whatsapp";
	echo "Necessario fazer a exportacao da mensagem direto do aplicativo."
	echo "Para mais informacoes visite meu github"
	echo "Este script utiliza apenas o shellscript."
	echo ""
	echo "https://github.com/faciltech"
        echo "########################################################"
        echo "$(tput setaf 3)" "$(tput blink)" "########## Autor: Eduardo Amaral ##############" "$(tput sgr0)"
        echo "########################################################"
        echo ""
        echo "Caso queira apenas pesquisar use da seguinte forma:"
        echo "[+]  Ex2: ./zap.sh <dados>.txt @hotmail"

if [ "$1" == "" ];   
then
	echo "Use o script da seguinte forma: "
	echo "Ex1: ./zap.sh <arquivo>.txt"

elif [ "$#" == "1" ];
then     
	clear
	echo "Este programa faz uma extracao de dados de mensagens do whatsapp";
	echo "Necessario fazer a exportacao da mensagem direto do aplicativo."
	echo "Para mais informacoes visite meu github"
	echo "Este script utiliza apenas o shellscript."
	echo ""
	echo "https://github.com/faciltech"
	echo "########################################################"
	echo "$(tput setaf 3)" "$(tput blink)" "########## Autor: Eduardo Amaral ##############" "$(tput sgr0)"
	echo "########################################################"
	echo "[+]  Voce precisa exportar o arquivo de conversa do grupo."
	echo "[+]  Ex1: ./zap.sh <dados>.txt"
	echo ""
	echo "Caso queira apenas pesquisar use da seguinte forma:"
	echo "[+]  Ex2: ./zap.sh <dados>.txt @hotmail"
	
	sleep 2

	arquivo=$1
	criacao=$(head $arquivo | grep "criou");
	data_criacao=$(head $arquivo | grep "criou"  | cut -d" " -f 1,2);
	dono=$(head $arquivo | grep "criou" | cut -d" " -f 6);
	echo ""
	echo -n "Digite o Nome do grupo: "
	read nome_grupo

	if [ -d "./$nome_grupo" ];
	then
        	cd $nome_grupo
       
	else
        	mkdir $nome_grupo
        	cd $nome_grupo
	fi

	while :
	do
		echo ""
		echo "[1] - Para extrair os telefones;"
		echo "[2] - Para extrair os links compartilhados;"
		echo "[3] - Para ver os administradores do grupo;"
		echo "[4] - Para ver quem saiu do grupo;"
		echo "[5] - Para ver relatorio completo"
		echo "[6] - Para sair"
		echo ""
		echo -n "Digite a opcao: "
	sleep 2
	read valor
	case $valor in
        	'1')
			echo ""
                	echo "__________TELEFONES ECONTRADOS: ____________ "
			echo ""
			cat ../$arquivo | grep "+55" | awk -F" " '{print $6,$7,$8}' | cut -d":" -f1 | grep -v "mudou" | grep "+" | grep -v "adicionou" | grep -v "removeu" | sort | uniq -u > telefones_$nome_grupo.txt
			echo "[+] Quantidade de numeros encontrados: "
			qtd=$(wc -l telefones_"$nome_grupo".txt | cut -d" " -f1)
			echo "Ao todo $qtd numeros de telefones."
			echo " "
			cat  telefones_"$nome_grupo".txt
			echo ""
			
                	;;
        	'2')
			echo ""
                	echo "----------- Links Encontrados ---------------------"
			cat ../$arquivo | grep "http" | cut -d" " -f8 | grep http > links_"$nome_grupo".txt
			cat links_"$nome_grupo".txt

                	;;
		'3')
                	echo ""
			echo "------ Provaveis Administradores ---";
			cat  ../$arquivo | grep "adicionou" | cut -d" " -f 6 | grep -v "+" | sort | uniq
			echo " "

                	;;
        	'4')
                	echo ""
			echo "________ Numeros que deixaram o grupo ____"
			cat ../$arquivo | grep "+" | cut -d" " -f 1,2,3,4,5,6,7,8,9 | grep saiu
			echo ""
                	;;
        	'5')
                	echo ""
			echo "Grupo foi criado em: $data_criacao, por $dono ";
			echo "Nome do grupo: $nome_grupo";
			echo " "
			echo "__________TELEFONES ECONTRADOS: ____________ "
			cat ../$arquivo | grep "+55" | awk -F" " '{print $6,$7,$8}' | cut -d":" -f1 | grep -v "mudou" | grep "+" | grep -v "adicionou" | grep -v "removeu" | sort | uniq -u > telefones_$nome_grupo.txt 
			echo "[+] Quantidade de numeros encontrados: "
			qtd=$(wc -l telefones_"$nome_grupo".txt | cut -d" " -f1)
			echo "Ao todo $qtd numeros de telefones."
			echo " "
			cat  telefones_"$nome_grupo".txt
			echo ""
			echo "_______ ACOES DE ADMINISTRADOR _____"
			cat ../$arquivo | grep "adicionou"
			echo " "
			echo "------ Provaveis Administradores ---";
			cat  ../$arquivo | grep "adicionou" | cut -d" " -f 6 | grep -v "+" | sort | uniq
			echo " "
			echo "________ Numeros que deixaram o grupo ____"
			cat ../$arquivo | grep "+" | cut -d" " -f 1,2,3,4,5,6,7,8,9 | grep saiu
			echo ""
			echo "----------- Links Encontrados ---------------------"
			cat ../$arquivo | grep "http" | cut -d" " -f8 | grep http > links_"$nome_grupo".txt
			cat links_"$nome_grupo".txt
                	;;
        	'6')
                	exit
                	;;
		*)
			echo "Essa opcao nao e valida."                        
                        ;;
	esac
	done
else
	grep -i $2 $1

fi
