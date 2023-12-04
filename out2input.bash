#!/bin/bash

for out in output.dat0.*; do 
  index=$(echo ${out} | cut -d. -f3)
  echo ${index}
  mv ${out} input.dat0.${index}
done