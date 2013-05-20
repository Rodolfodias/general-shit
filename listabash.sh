#!/bin/bash

echo "/////////////////////" | tee -a desactivados.txt expiracao.txt
echo `date` | tee -a desactivados.txt expiracao.txt
echo "/////////////////////" | tee -a desactivados.txt expiracao.txt

for line in $(cat listadobind.txt)
do
        if echo $line | grep -q "\."                                                    # verifica se a linha lida é, de facto, um domínio
        then
                echo -e $line
                bindResult=$(whois $line)                                               # por forma a fazer-se apenas um whois e não sobrecarregar a rede

                dados=$(echo "${bindResult}" | grep -i "No Match\|Not Found" )          # verifica se o domínio lido está em funcionamento actualmente
                if [ -n "$dados" ]
                then
                        echo "ENTRADA DESAPARECIDA"
                        echo -e $line >> desactivados.txt                               # regista os domínios desactivados num ficheiro
                else
                        echo -e $line >> expiracao.txt
                        echo "${bindResult}" | grep -i "Name Server\|NameServer\|nserver"
                        echo "${bindResult}" | grep -i "Data de registo\|Creation Date\|created" | head -1
                        echo "${bindResult}" | grep -i "Data de Expiração\|Expiration Date\|expires" | head -1 | tee -a expiracao.txt           
                fi
        fi
done
echo "/////////////////////" | tee -a desactivados.txt expiracao.txt

# /////IDEIAS/////
# -cada domínio ser testado consoante o seu TLD (string tokenizers)
# -armazenar-se a sua data de expiração com string tokenizers, dependendo do ponto anterior
# -ordenarem-se por data de expiração
