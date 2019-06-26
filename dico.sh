#!/bin/bash

##########_header_#######################
#Nom: dico.sh
#Utilité: recherche dans dico
#Usage: 
#       ./dico.sh 5 i2 u4 
# On cherche un mot de 5 lettres, dont la 2ème est un i et la 4ème un u
#Auteur: k-chien
#Mise-à-jour: 20192606
#########################################

path="/usr/share/dict"
dico_name=""
declare -i long #la longueur du mot cherché

if [[ $# -eq 0 ]] ; then
    echo "Vous devez obligatoirement rentrer un paramètre, le nombre de lettres." 
    exit 1
fi

for arg in "$@" ; do
    if [[ $arg == $1 ]] ; then
        long=$arg
        #on obtient un mot aléatoire de $long caractères
        motAlea=$(head /dev/urandom | tr -dc a-zA-Z | head -c $long) # -dc for delete complement
        #on met que des . pour le test regex (any char) 
        regex=$(echo $motAlea | sed 's/././g')
    else
        lettre=${arg:0:1}
        pos=${arg:(-1)}
        regex=$(sed "s/./$lettre/$pos" <<< $regex)
    fi
done
# -n pour afficher le numéro de ligne correspondant
grep -n "^$regex$" $path/$dico_name
exit 0
