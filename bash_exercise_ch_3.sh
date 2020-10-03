#!/bin/bash
#grep all non-header lines of multifasta, grep all Gs and Cs and count
a=$(grep -v \> paxillus.fna | grep -o "[GC]" | wc -m)
#same as above, but now grep all nucleotides and count
b=$(grep -v \> paxillus.fna | grep -o "[GCAT]" | wc -m)
#calculate GC%
echo "GC%:"
x=$(echo "$a"/"$b" | bc -l)
echo "$x"
#count exact occurrences of GAAGTC
c=$(grep -v \> paxillus.fna | grep -o "GAAGTC" | wc -l)
#printf is more predictable
echo "Nr of occurences of GAAGTC in multifasta: $c"
#extract sequence IDs (pattern to hit up until first space)
#trim > and swap newlines for spaces
grep "\>\S*" paxillus.fna | tr -d '\>' | tr '\n' ' '>no_newline_pax.txt
# grep : and count the number of lines produced in output
d=$(grep -o ":" no_newline_pax.txt | wc -l)
# grep spaces and count lines
e=$(grep -o ' ' no_newline_pax.txt | wc -l)
echo ":+spaces+newline sum:"
y=$(echo "$d"+"$e"+1 | bc -l)
echo "$y"
rm -f no_newline_pax.txt || exit
