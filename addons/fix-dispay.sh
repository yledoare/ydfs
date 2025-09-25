OUTPUT=$(xrandr |grep primary |cut -d' ' -f1)
echo Output is $OUTPUT
xrandr --output $OUTPUT --set underscan auto
