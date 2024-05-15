#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

INPUT=$1
if [[ $INPUT =~ ^[0-9]+$ ]]
then 
  tryElements=$($PSQL "SELECT * FROM elements WHERE atomic_number = $INPUT")
  echo "I could not find that element in the database."
else
  if [[ $INPUT ]]
  then
    tryElements=$($PSQL "SELECT * FROM elements WHERE symbol = '$INPUT' OR name = '$INPUT'")
    if [[ -z $tryElements ]]
    then
    echo "I could not find that element in the database."
    else
      getElements=$($PSQL "SELECT * FROM elements e FULL JOIN properties p ON e.atomic_number = p.atomic_number")
      echo "$getElements" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_NUMBER BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE_ID
      do
        case $INPUT in
          $ATOMIC_NUMBER|$SYMBOL|$NAME) 
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
          ;;
        esac
      done
    fi
  else
    echo "Please provide an element as an argument."
  fi
fi