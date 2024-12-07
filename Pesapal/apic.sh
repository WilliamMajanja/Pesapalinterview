#!/bin/bash

function add() {
  local num1="$1"
  local num2="$2"

  # Ensure both numbers have the same length
  while [[ ${#num1} -lt ${#num2} ]]; do
    num1="0$num1"
  done
  while [[ ${#num2} -lt ${#num1} ]]; do
    num2="0$num2"
  done

  local result=""
  local carry=0
  for (( i=${#num1}-1; i>=0; i-- )); do
    local digit=$(( ${num1:$i:1} + ${num2:$i:1} + $carry ))
    carry=$(( digit / 10 ))
    result="${digit%10}$result"
  done
  if [[ $carry -gt 0 ]]; then
    result="$carry$result"
  fi

  echo "$result"
}

function subtract() {
  # Implement subtraction logic, similar to addition
}

function multiply() {
  # Implement multiplication logic, using long multiplication
}

function divide() {
  # Implement division logic, using long division
}

while true; do
  read -p "Enter an expression: " expression

  # Use a simple parser to extract numbers and operators
  # (A more robust parser would be needed for complex expressions)
  if [[ $expression =~ ^([0-9]+) ([+-*/]) ([0-9]+)$ ]]; then
    num1="${BASH_REMATCH[1]}"
    operator="${BASH_REMATCH[2]}"
    num2="${BASH_REMATCH[3]}"

    case "$operator" in
      +)
        result=$(add "$num1" "$num2")
        ;;
      -)
        result=$(subtract "$num1" "$num2")
        ;;
      *)
        echo "Invalid operator"
        continue
        ;;
    esac

    echo "Result: $result"
  else
    echo "Invalid expression"
  fi
done
