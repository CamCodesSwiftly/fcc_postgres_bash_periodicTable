#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

cannotFind() {
  echo "I could not find that element in the database." 
}


if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  # input number or string?
  # use arithmetic != to determine if itself is itself
  # if yes, it has to be numeric, if not then not
  if [[ $1 != $(($1)) ]]
  then
    # is it the symbol?
    # if input length is greater or equal 3
    if [[ ${#1} -ge 3 ]]
    then
      # find element by its name
      ELEMENT_BY_NAME=($($PSQL "SELECT * FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE name='$1'"))
      if [[ -z $ELEMENT_BY_NAME ]] 
      then
        cannotFind
      else
        ELEMENT_BY_NAME_ATOMIC_NUMBER=($($PSQL "SELECT atomic_number FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE name='$1'"))
        ELEMENT_BY_NAME_SYMBOL=($($PSQL "SELECT symbol FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE name='$1'"))
        ELEMENT_BY_NAME_NAME=$1
        ELEMENT_BY_NAME_ATOMIC_MASS=($($PSQL "SELECT atomic_mass FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE name='$1'"))
        ELEMENT_BY_NAME_MELTING_POINT_CELSIUS=($($PSQL "SELECT melting_point_celsius FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE name='$1'"))
        ELEMENT_BY_NAME_BOILING_POINT_CELSIUS=($($PSQL "SELECT boiling_point_celsius FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE name='$1'"))
        ELEMENT_BY_NAME_TYPE=($($PSQL "SELECT type FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE name='$1'"))
        echo The element with atomic number $ELEMENT_BY_NAME_ATOMIC_NUMBER is $ELEMENT_BY_NAME_NAME \($ELEMENT_BY_NAME_SYMBOL\). It\'s a $ELEMENT_BY_NAME_TYPE, with a mass of $ELEMENT_BY_NAME_ATOMIC_MASS amu. $ELEMENT_BY_NAME_NAME has a melting point of $ELEMENT_BY_NAME_MELTING_POINT_CELSIUS celsius and a boiling point of $ELEMENT_BY_NAME_BOILING_POINT_CELSIUS celsius.
      fi
    else
      ELEMENT_BY_SYMBOL=$($PSQL "SELECT * FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE symbol='$1';")
      # !!!!! Case Sensitivity? Li vs li for Lithium? li does not work!
      if [[ -z $ELEMENT_BY_SYMBOL ]] 
      then
        cannotFind
      else
        ELEMENT_BY_SYMBOL_ATOMIC_NUMBER=($($PSQL "SELECT atomic_number FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE symbol='$1'"))
        ELEMENT_BY_SYMBOL_SYMBOL=$1
        ELEMENT_BY_SYMBOL_NAME=($($PSQL "SELECT name FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE symbol='$1'"))
        ELEMENT_BY_SYMBOL_ATOMIC_MASS=($($PSQL "SELECT atomic_mass FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE symbol='$1'"))
        ELEMENT_BY_SYMBOL_MELTING_POINT_CELSIUS=($($PSQL "SELECT melting_point_celsius FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE symbol='$1'"))
        ELEMENT_BY_SYMBOL_BOILING_POINT_CELSIUS=($($PSQL "SELECT boiling_point_celsius FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE symbol='$1'"))
        ELEMENT_BY_SYMBOL_TYPE=($($PSQL "SELECT type FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE symbol='$1'"))
        echo The element with atomic number $ELEMENT_BY_SYMBOL_ATOMIC_NUMBER is $ELEMENT_BY_SYMBOL_NAME \($ELEMENT_BY_SYMBOL_SYMBOL\). It\'s a $ELEMENT_BY_SYMBOL_TYPE, with a mass of $ELEMENT_BY_SYMBOL_ATOMIC_MASS amu. $ELEMENT_BY_SYMBOL_NAME has a melting point of $ELEMENT_BY_SYMBOL_MELTING_POINT_CELSIUS celsius and a boiling point of $ELEMENT_BY_SYMBOL_BOILING_POINT_CELSIUS celsius.
      fi
    fi
  else
    ELEMENT_BY_NUMBER=$($PSQL "SELECT * FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE atomic_number=$1")
    if [[ -z $ELEMENT_BY_NUMBER ]] 
    then
      cannotFind
    else
        ELEMENT_BY_NUMBER_ATOMIC_NUMBER=$1
        ELEMENT_BY_NUMBER_SYMBOL=($($PSQL "SELECT symbol FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE atomic_number=$1"))
        ELEMENT_BY_NUMBER_NAME=($($PSQL "SELECT name FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE atomic_number=$1"))
        ELEMENT_BY_NUMBER_ATOMIC_MASS=($($PSQL "SELECT atomic_mass FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE atomic_number=$1"))
        ELEMENT_BY_NUMBER_MELTING_POINT_CELSIUS=($($PSQL "SELECT melting_point_celsius FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE atomic_number=$1"))
        ELEMENT_BY_NUMBER_BOILING_POINT_CELSIUS=($($PSQL "SELECT boiling_point_celsius FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE atomic_number=$1"))
        ELEMENT_BY_NUMBER_TYPE=($($PSQL "SELECT type FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE atomic_number=$1"))
        echo The element with atomic number $ELEMENT_BY_NUMBER_ATOMIC_NUMBER is $ELEMENT_BY_NUMBER_NAME \($ELEMENT_BY_NUMBER_SYMBOL\). It\'s a $ELEMENT_BY_NUMBER_TYPE, with a mass of $ELEMENT_BY_NUMBER_ATOMIC_MASS amu. $ELEMENT_BY_NUMBER_NAME has a melting point of $ELEMENT_BY_NUMBER_MELTING_POINT_CELSIUS celsius and a boiling point of $ELEMENT_BY_NUMBER_BOILING_POINT_CELSIUS celsius.
      fi
  fi

  #ELEMENT=$($PSQL "SELECT * FROM elements WHERE atomic_number=$1")
  # find element
  #echo $ELEMENT
  #if [[ -z $ELEMENT ]]
  #then
  #  echo "I could not find that element in the database." 
  #fi
fi

