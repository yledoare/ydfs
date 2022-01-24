find . -type f | while read file
do
  grep $1 $file && echo -n  "- Found in $file" && echo && echo
done
