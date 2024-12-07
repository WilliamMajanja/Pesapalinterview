#!/bin/bash

function calculate() {
  echo "Enter your mathematical expression:"
  read expression

  # Evaluate the expression using bc
  result=$(echo "$expression" | bc)

  echo "Result: $result"
}

while true; do
  calculate

  echo "Do you want to perform another calculation? (yes/no)"
  read answer

  if [[ "$answer" != "yes" ]]; then
    break
  fi
done
