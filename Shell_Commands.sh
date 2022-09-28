# Awk commands
#---------------------------------------
##########################
# Command to introduce space between each line in awk.
echo -e "a\nb\nc" | awk '{ print($0); system("sleep 1")}'
##########################
