#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

MAIN_MENU() {
  if [[ $1 ]]
  then
    #echo "it works"
    #CHECKNUMBER='^[0-9]+$'
    if [[ $1 =~ ^[0-9]+$ ]]
    then
      NUMBER $1
    else
      if [[ ${#1} -gt 2 ]]
      then
        NAME $1
      else
        SYMBOL $1
      fi
    fi
  else
    echo "Please provide an element as an argument."
  fi
}

NUMBER() {
  NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$1")
  if [[ $NAME ]]
  then
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1")
    TYPE=$($PSQL "SELECT types.type FROM types INNER JOIN properties ON types.type_id = properties.type_id WHERE atomic_number=$1")
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$1")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$1")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$1")
    echo "The element with atomic number $1 is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    else
    echo "I could not find that element in the database."
  fi
}

NAME() {
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")
  if [[ $ATOMIC_NUMBER ]]
  then
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name='$1'")
    TYPE=$($PSQL "SELECT types.type FROM types INNER JOIN properties ON types.type_id = properties.type_id WHERE atomic_number=$ATOMIC_NUMBER")
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    echo "The element with atomic number $ATOMIC_NUMBER is $1 ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $1 has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    else
    echo "I could not find that element in the database."
  fi
    
}

SYMBOL() {
  NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$1'")
  if [[ $NAME ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")
    TYPE=$($PSQL "SELECT types.type FROM types INNER JOIN properties ON types.type_id = properties.type_id WHERE atomic_number=$ATOMIC_NUMBER")
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($1). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    else
    echo "I could not find that element in the database."
  fi
}

MAIN_MENU $1