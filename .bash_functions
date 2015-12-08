##################################################
#	 Add a defined function to .bash_functions	 #
##################################################

function addfunction() { declare -f $1 >> ~/.bash_functions ; }

##################################################
#	 Add a defined alias to ~/.bash_aliases 	 #
##################################################

function addalias() { declare -f $1 >> ~/.bash_aliases ; }

##################################################
#  Quick reference color charts	& color stuff    #
##################################################

##### shows a gui color chart
function color-picker()
{
# for GNOME2 only
# sudo apt-get install python-gtkmozembed xulrunner-2.0
# also requires: "~/.gnome2/nemo-scripts/.colorchart/view.html"
echo "When you are finished, press "Control C" to continue..."
cat > "/tmp/color-picker.py" <<"End-of-message"
#!/usr/bin/python
import os
import pygtk
pygtk.require('2.0')
import gtk
import gtkmozembed
homedir = os.path.expanduser('~')
try:
    from win32com.shell import shellcon, shell
    homedir = shell.SHGetFolderPath(0, shellcon.CSIDL_APPDATA, 0, 0)
except ImportError:
    homedir = os.path.expanduser("~/.gnome2/nemo-scripts/.colorchart/view.html")
class ColorChart:
	def __init__(self):
                self.moz = gtkmozembed.MozEmbed()
		box = gtk.VBox(False,0)
		win = gtk.Window()
		win.add(box)
		hbox = gtk.HBox(False,0)
                box.pack_start(hbox,False,False)
                hbox.show()
		box.pack_start(self.moz,True,True,0)
                self.moz.show()
		self.moz.load_url(homedir)
                self.moz.set_size_request(650,550)
		title=self.moz.get_title()
		win.set_title("RGB/HEX Color Picker")
		win.show_all()
if __name__ == "__main__":
	ColorChart()
	gtk.main()
End-of-message
chmod +x "/tmp/color-picker-.py"
/usr/bin/python "/tmp/color-picker.py"
/bin/rm "/tmp/color-picker.py"
}

###### shows a gui color chart
# function color-picker()
# {
# # for GNOME3 only
# # sudo apt-get install python-webkit
# # also requires: "~/.gnome2/nemo-scripts/.colorchart/view.html"
# echo "When you are finished, press "Control C" to continue..."
# cat > "/tmp/color-picker.py" <<"End-of-message"
# #!/usr/bin/python
# import os
# import pygtk
# pygtk.require('2.0')
# import gtk
# import webkit
# homedir = os.path.expanduser('~')
# try:
#     from win32com.shell import shellcon, shell
#     homedir = shell.SHGetFolderPath(0, shellcon.CSIDL_APPDATA, 0, 0)
# except ImportError:
#     homedir = os.path.expanduser("~/.gnome2/nemo-scripts/.colorchart/view.html")
# class ColorChart:
# 	def __init__(self):
#                 self.moz = webkit.WebView()
# 		box = gtk.VBox(False,0)
# 		win = gtk.Window()
# 		win.add(box)
# 		hbox = gtk.HBox(False,0)
#                 box.pack_start(hbox,False,False)
#                 hbox.show()
# 		box.pack_start(self.moz,True,True,0)
#                 self.moz.show()
# 		self.moz.open(homedir)
#                 self.moz.set_size_request(650,550)
# 		title=self.moz.get_title()
# 		win.set_title("RGB/HEX Color Picker")
# 		win.show_all()
# if __name__ == "__main__":
# 	ColorChart()
# 	gtk.main()
# End-of-message
# chmod +x "/tmp/color-picker-.py"
# /usr/bin/python "/tmp/color-picker.py"
# /bin/rm "/tmp/color-picker.py"
# }


###### takes a name of a color and some text and then echoes out the text in the named color
# Usage:	colorize_text "color" "whatever text"
function colorize-text()
{
b='[0;30m'

## Implement command-line options
while getopts "nr" opt
 do
  case $opt in
   n  )  o='-n' ;;
   r  )  b=''   ;;
  esac
 done
shift $(($OPTIND - 1))
## Set variables
col=$1
shift
text="$*"
## Set a to console color code
case $col in
 'black'  ) a='[0;30m' ;;
 'blue'   ) a='[0;34m' ;;
 'green'  ) a='[0;32m' ;;
 'cyan'   ) a='[0;36m' ;;
 'red'    ) a='[0;31m' ;;
 'purple' ) a='[0;35m' ;;
 'brown'  ) a='[0;33m' ;;
 'ltgray' ) a='[0;37m' ;;
 'white'  ) a='[1;30m' ;;
 'ltblue' ) a='[1;34m' ;;
 'ltgreen') a='[1;32m' ;;
 'ltcyan' ) a='[1;36m' ;;
 'ltred'  ) a='[1;31m' ;;
 'pink'   ) a='[1;35m' ;;
 'yellow' ) a='[1;33m' ;;
 'gray'   ) a='[1;37m' ;;
esac
## Display text in designated color, no newline
echo -en "\033$a$text"
## If 'b' switch not on, restore color to black
if [ -n $b ]
 then
  echo -en "\033$b"
fi
## If 'n' switch on, do not display final newline
## otherwise output newline
echo $o
}


###### shows the colors in a kewl way...partially stolen from HH
function colors()
{
    # Display ANSI colours.
    esc="\033["
    echo -e "\t  40\t   41\t   42\t    43\t      44       45\t46\t 47"
    for fore in 30 31 32 33 34 35 36 37; do
        line1="$fore  "
        line2="    "
        for back in 40 41 42 43 44 45 46 47; do
            line1="${line1}${esc}${back};${fore}m Normal  ${esc}0m"
            line2="${line2}${esc}${back};${fore};1m Bold    ${esc}0m"
        done
        echo -e "$line1\n$line2"
    done
    echo ""
    echo "# Example:"
    echo "#"
    echo "# Type a Blinkin TJEENARE in Swedens colours (Yellow on Blue)"
    echo "#"
    echo "#           ESC"
    echo "#            |  CD"
    echo "#            |  | CD2"
    echo "#            |  | | FG"
    echo "#            |  | | |  BG + m"
    echo "#            |  | | |  |         END-CD"
    echo "#            |  | | |  |            |"
    echo "# echo -e '\033[1;5;33;44mTJEENARE\033[0m'"
    echo "#"
    echo "# Sedika Signing off for now ;->"
}



###### displays all 256 possible background colors, using ANSI escape sequences.
# author: Chetankumar Phulpagare
# used in ABS Guide with permission.
function colors2()
{
T1=8
T2=6
T3=36
offset=0
for num1 in {0..7}
do {
   for num2 in {0,1}
       do {
          shownum=`echo "$offset + $T1 * ${num2} + $num1" | bc`
          echo -en "\E[0;48;5;${shownum}m color ${shownum} \E[0m"
          }
       done
   echo
   }
done
offset=16
for num1 in {0..5}
do {
   for num2 in {0..5}
       do {
          for num3 in {0..5}
              do {
                 shownum=`echo "$offset + $T2 * ${num3} \
                 + $num2 + $T3 * ${num1}" | bc`
                 echo -en "\E[0;48;5;${shownum}m color ${shownum} \E[0m"
                 }
               done
          echo
          }
       done
}
done
offset=232
for num1 in {0..23}
do {
   shownum=`expr $offset + $num1`
   echo -en "\E[0;48;5;${shownum}m ${shownum}\E[0m"
}
done
echo
}

###### print all 256 colors for testing TERM or for a quick reference
# show numerical values for each of the 256 colors in bash
function colors2nums()
{
for code in {0..255}; do echo -e "\033[38;05;${code}m $code: Test"; done
}


###### replaces a color in PDF document (useful for removing dark background for printing)
# usage:	remove_color input.pdf output.pdf
function uncolorpdf()
{
convert -density 300 "$1" -fill "rgb(255,255,255)" -opaque "rgb(0,0,0)" "$2"
}

	
##################################################
# Function you want after you've overwritten some#
# 	important file using > instead of >> ^^		 #
##################################################

function append() {
        lastarg="${!#}"
        echo "${@:1:$(($#-1))}" >> "$lastarg"
}

##################################################
# 	Numerical conversions and numbers stuff		 #
##################################################

###### convert arabic to roman numerals
# Copyright 2007 - 2010 Christopher Bratusek
function arabic2roman() {

  echo $1 | sed -e 's/1...$/M&/;s/2...$/MM&/;s/3...$/MMM&/;s/4...$/MMMM&/
s/6..$/DC&/;s/7..$/DCC&/;s/8..$/DCCC&/;s/9..$/CM&/
s/1..$/C&/;s/2..$/CC&/;s/3..$/CCC&/;s/4..$/CD&/;s/5..$/D&/
s/6.$/LX&/;s/7.$/LXX&/;s/8.$/LXXX&/;s/9.$/XC&/
s/1.$/X&/;s/2.$/XX&/;s/3.$/XXX&/;s/4.$/XL&/;s/5.$/L&/
s/1$/I/;s/2$/II/;s/3$/III/;s/4$/IV/;s/5$/V/
s/6$/VI/;s/7$/VII/;s/8$/VIII/;s/9$/IX/
s/[0-9]//g'

}


###### convert ascii
# copyright 2007 - 2010 Christopher Bratusek
function asc2all() {
	if [[ $1 ]]; then
		echo "ascii $1 = binary $(asc2bin $1)"
		echo "ascii $1 = octal $(asc2oct $1)"
		echo "ascii $1 = decimal $(asc2dec $1)"
		echo "ascii $1 = hexadecimal $(asc2hex $1)"
		echo "ascii $1 = base32 $(asc2b32 $1)"
		echo "ascii $1 = base64 $(asc2b64 $1)"
	fi
}

function asc2bin() {
	if [[ $1 ]]; then
		echo "obase=2 ; $(asc2dec $1)" | bc
	fi
}

function asc2b64() {
	if [[ $1 ]]; then
		echo "obase=64 ; $(asc2dec $1)" | bc
	fi
}

function asc2b32() {
	if [[ $1 ]]; then
		echo "obase=32 ; $(asc2dec $1)" | bc
	fi
}

function asc2dec() {
	if [[ $1 ]]; then
		printf '%d\n' "'$1'"
	fi
}

function asc2hex() {
	if [[ $1 ]]; then
		echo "obase=16 ; $(asc2dec $1)" | bc
	fi
}



function asc2oct() {
	if [[ $1 ]]; then
		echo "obase=8 ; $(asc2dec $1)" | bc
	fi
}

###### temperature conversion
# Copyright 2007 - 2010 Christopher Bratusek
function cel2fah() {

  if [[ $1 ]]; then
	echo "scale=2; $1 * 1.8  + 32" | bc
  fi

}

function fah2cel() {

  if [[ $1 ]]; then
	echo "scale=2 ; ( $1 - 32  ) / 1.8" | bc
  fi

}

###### convert phone numbers to letters/potentially english words
# Creator:	asmoore82
function phone2text()
{
echo -n "Enter number: "
read num
# Create a list of possibilites for expansion by the shell
# the "\}" is an ugly hack to get "}" into the replacment string -
# this is not a clean escape sequence - the litteral "\" is left behind!
num="${num//2/{a,b,c\}}"
num="${num//3/{d,e,f\}}"
num="${num//4/{g,h,i\}}"
num="${num//5/{j,k,l\}}"
num="${num//6/{m,n,o\}}"
num="${num//7/{p,q,r,s\}}"
num="${num//8/{t,u,v\}}"
num="${num//9/{w,x,y,z\}}"
# cleaup from the hack - remove all litteral \'s
num="${num//\\/}"
echo ""
echo "Possible words are:"
for word in $( eval echo "$num" )
do
    echo '>' "$word"
done
# End of File
}


##################################################
# 				Compress stuff					 #
##################################################

function compress_() {
   # Credit goes to: Daenyth
   FILE=$1
   shift
   case $FILE in
      *.tar.bz2) tar cjf $FILE $*  ;;
      *.tar.gz)  tar czf $FILE $*  ;;
      *.tgz)     tar czf $FILE $*  ;;
      *.zip)     zip $FILE $*      ;;
      *.rar)     rar $FILE $*      ;;
      *)         echo "Filetype not recognized" ;;
   esac
}

##################################################
# 	Extract - extract most common compression	 #
# 					types						 #
##################################################

# function extract() {
#   local e=0 i c
#   for i; do
#     if [[ -f $i && -r $i ]]; then
#         c=''
#         case $i in
#           *.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
#                  c='bsdtar xvf' ;;
#           *.7z)  c='7z x'       ;;
#           *.Z)   c='uncompress' ;;
#           *.bz2) c='bunzip2'    ;;
#           *.exe) c='cabextract' ;;
#           *.gz)  c='gunzip'     ;;
#           *.rar) c='unrar x'    ;;
#           *.xz)  c='unxz'       ;;
#           *.zip) c='unzip'      ;;
#           *)     echo "$0: cannot extract \`$i': Unrecognized file extension" >&2; e=1 ;;
#         esac
#         [[ $c ]] && command $c "$i"
#     else
#         echo "$0: cannot extract \`$i': File is unreadable" >&2; e=2
#     fi
#   done
#   return $e
# }

##################################################
# Shell function to exit script with error in 	 #
# exit status and print optional message to 	 #
# 					stderr						 #
##################################################

function die() { result=$1;shift;[ -n "$*" ]&&printf "%s\n" "$*" >&2;exit $result;}

##################################################
# 	Determining the meaning of error codes		 #
##################################################

function err()
{
    grep --recursive --color=auto --recursive -- "$@" /usr/include/*/errno.h
    if [ "${?}" != 0 ]; then
        echo "Not found."
    fi
}

##################################################
# 	Recursively fix dir/file permissions on a	 #
# 				given directory					 #
##################################################

function fix() {
if [ -d $1 ]; then
find $1 -type d -exec chmod 755 {} \;
find $1 -type f -exec chmod 644 {} \;
else
echo "$1 is not a directory."
fi
}

##################################################
#			 Weather and stuff					 #
##################################################

###### 10-day forcast
# USAGE:	forecast 50315
function forecast() {
_ZIP=$1

if   [ $# = 1 ];then
     printf "$_ZIP\n" | egrep '^[0-9][0-9][0-9][0-9][0-9]$' >>/dev/null
     if   [ $? = 0 ];then
          printf "Your 10 Day Weather Forecast as follows:\n";
          lynx -dump "http://www.weather.com/weather/print/$_ZIP" | sed -n '/%$/s/\[.*\]//p';
          printf "\n"
     elif [ $? = 1 ];then
          printf "Bad ZIP code!\n"
     fi
elif [ $# != 1 ];then
     printf "You need to supply a ZIP code!\n"
fi
}


###### get sunrise and sunset times
function suntimes()
{
l=12765843;curl -s http://weather.yahooapis.com/forecastrss?w=$l|grep astronomy| awk -F\" '{print $2 "\n" $4;}'
}

###### weather by US zip code - Can be called two
# ways	# weather 50315	# weather "Des
# Moines"
function weather_()
{
declare -a WEATHERARRAY
WEATHERARRAY=( `lynx -dump http://google.com/search?q=weather+$1 | grep -A 5 '^ *Weather for' | grep -v 'Add to'`)
echo ${WEATHERARRAY[@]}
}

##################################################
# 				Progress visuals				 #
##################################################

##### Cp with progress bar (using pv)		
function cp_p() {
	if [ `echo "$2" | grep ".*\/$"` ]
	then
		pv "$1" > "$2""$1"
	else
		pv "$1" > "$2"/"$1"
	fi
}

###### display animated hourglass in the shell to indicate ongoing processing
function hourglass() { s=$(($SECONDS +${1:-10}));(tput civis;while [[ $SECONDS -lt $s ]];do for f in '|' ' ' '\-' /;do echo -n $f&&sleep .2s&&tput cub1;done;done);tput cnorm; }


###### pretty progressbar
function progressbar()
# copyright 2007 - 2010 Christopher Bratusek
{
	SP_COLOUR="\e[37;44m"
	SP_WIDTH=5.5
	SP_DELAY=0.2
	SP_STRING=${2:-"'|/=\'"}
	while [ -d /proc/$1 ]
	do
		printf "$SP_COLOUR\e7  %${SP_WIDTH}s  \e8\e[01;37m" "$SP_STRING"
		sleep ${SP_DELAY:-.2}
		SP_STRING=${SP_STRING#"${SP_STRING%?}"}${SP_STRING%?}
	done
	tput sgr0
}


###### please wait...
# copyright 2007 - 2010 Christopher Bratusek
function spanner() {
	PROC=$1;COUNT=0
	echo -n "Please wait "
	while [ -d /proc/$PROC ];do
		while [ "$COUNT" -lt 10 ];do
			echo -ne '\x08  ' ; sleep 0.1
			((COUNT++))
		done
		until [ "$COUNT" -eq 0 ];do
			echo -ne '\x08\x08 ' ; sleep 0.1
			((COUNT -= 1))
		done
	done
}


function spin() {
	# copyright 2007 - 2010 Christopher Bratusek
        echo -n "|/     |"
        while [ -d /proc/$1 ]
        do
        # moving right
        echo -ne "\b\b\b\b\b\b\b-     |"
        sleep .05
        echo -ne "\b\b\b\b\b\b\b\\     |"
        sleep .05
        echo -ne "\b\b\b\b\b\b\b|     |"
        sleep .05
        echo -ne "\b\b\b\b\b\b\b /    |"
        sleep .05
        echo -ne "\b\b\b\b\b\b-    |"
        sleep .05
        echo -ne "\b\b\b\b\b\b\\    |"
        sleep .05
        echo -ne "\b\b\b\b\b\b|    |"
        sleep .05
        echo -ne "\b\b\b\b\b\b /   |"
        sleep .05
        echo -ne "\b\b\b\b\b-   |"
        sleep .05
        echo -ne "\b\b\b\b\b\\   |"
        sleep .05
        echo -ne "\b\b\b\b\b|   |"
        sleep .05
        echo -ne "\b\b\b\b\b /  |"
        sleep .05
        echo -ne "\b\b\b\b-  |"
        sleep .05
        echo -ne "\b\b\b\b\\  |"
        sleep .05
        echo -ne "\b\b\b\b|  |"
        sleep .05
        echo -ne "\b\b\b\b / |"
        sleep .05
        echo -ne "\b\b\b- |"
        sleep .05
        echo -ne "\b\b\b\\ |"
        sleep .05
        echo -ne "\b\b\b| |"
        sleep .05
        echo -ne "\b\b\b /|"
        sleep .05
        echo -ne "\b\b-|"
        sleep .05
        echo -ne "\b\b\\|"
        sleep .05
        echo -ne "\b\b||"
        sleep .05
        echo -ne "\b\b/|"
        sleep .05
        # moving left
        echo -ne "\b\b||"
        sleep .05
        echo -ne "\b\b\\|"
        sleep .05
        echo -ne "\b\b-|"
        sleep .05
        echo -ne "\b\b\b/ |"
        sleep .05
        echo -ne "\b\b\b| |"
        sleep .05
        echo -ne "\b\b\b\\ |"
        sleep .05
        echo -ne "\b\b\b- |"
        sleep .05
        echo -ne "\b\b\b\b/  |"
        sleep .05
        echo -ne "\b\b\b\b|  |"
        sleep .05
        echo -ne "\b\b\b\b\\  |"
        sleep .05
        echo -ne "\b\b\b\b-  |"
        sleep .05
        echo -ne "\b\b\b\b\b/   |"
        sleep .05
        echo -ne "\b\b\b\b\b|   |"
        sleep .05
        echo -ne "\b\b\b\b\b\\   |"
        sleep .05
        echo -ne "\b\b\b\b\b-   |"
        sleep .05
        echo -ne "\b\b\b\b\b\b/    |"
        sleep .05
        echo -ne "\b\b\b\b\b\b|    |"
        sleep .05
        echo -ne "\b\b\b\b\b\b\\    |"
        sleep .05
        echo -ne "\b\b\b\b\b\b-    |"
        sleep .05
        echo -ne "\b\b\b\b\b\b\b/     |"
        sleep .05
        done
	echo -e "\b\b\b\b\b\b\b\b\b|=======| done!"
}

function spinner()
# copyright 2007 - 2010 Christopher Bratusek
{
	PROC=$1
	while [ -d /proc/$PROC ];do
		echo -ne '\e[01;32m/\x08' ; sleep 0.05
		echo -ne '\e[01;32m-\x08' ; sleep 0.05
		echo -ne '\e[01;32m\\\x08' ; sleep 0.05
		echo -ne '\e[01;32m|\x08' ; sleep 0.05
	done
}

###### Display a progress process
# To start the spinner2 function, you have to send the function
# into the background. To stop the spinner2 function, you have
# to define the argument "stop".
# EXAMPLE:
#    echo -n "Starting some daemon "; spinner2 &
#    if sleep 10; then
#       spinner2 "stop"; echo -e "\t[ OK ]"
#    else
#       spinner2 "stop"; echo -e "\t[ FAILED ]"
#    fi
function spinner2() {
      local action=${1:-"start"}
      declare -a sign=( "-" "/" "|" "\\\\" )
      # define singnal file...
      [ "$action" = "start" ] && echo 1 > /tmp/signal
      [ "$action" = "stop" ] && echo 0 > /tmp/signal
      while [ "$( cat /tmp/signal 2>/dev/null )" == "1" ] ; do
          for (( i=0; i<${#sign[@]}; i++ )); do
              echo -en "${sign[$i]}\b"
              # with this command you can use millisecond as sleep time - perl rules ;-)
              perl -e 'select( undef, undef, undef, 0.1 );'
          done
      done
      # clear the last ${sign[$i]} sign at finish...
      [ "$action" = "stop" ] && echo -ne " \b"
}

##################################################
#			 Advanced ls functions				 #
##################################################

function la() {
	# copyright 2007 - 2010 Christopher Bratusek
	ls -A --group-directories-first "$@"
}


function lg() {
	# copyright 2007 - 2010 Christopher Bratusek
	if [[ "$@" == "" ]]; then
		$@="*"
	fi
	ls -l --group-directories-first "$@" | gawk '{print $9, "belongs to Group ->", $4}' | column -t
}


function ll() {
	# copyright 2007 - 2010 Christopher Bratusek
	ls -l --group-directories-first "$@"
}


###### Counts files, subdirectories and directory size and displays details
# about files depending on the available space
function lls() {
	# count files
	echo -n "<`find . -maxdepth 1 -mindepth 1 -type f | wc -l | tr -d '[:space:]'` files>"
	# count sub-directories
	echo -n " <`find . -maxdepth 1 -mindepth 1 -type d | wc -l | tr -d '[:space:]'` dirs/>"
	# count links
	echo -n " <`find . -maxdepth 1 -mindepth 1 -type l | wc -l | tr -d '[:space:]'` links@>"
	# total disk space used by this directory and all subdirectories
	echo " <~`du -sh . 2> /dev/null | cut -f1`>"
	ROWS=`stty size | cut -d' ' -f1`
	FILES=`find . -maxdepth 1 -mindepth 1 |
	wc -l | tr -d '[:space:]'`
	# if the terminal has enough lines, do a long listing
	if [ `expr "${ROWS}" - 6` -lt "${FILES}" ]; then
		ls
	else
		ls -hlAF --full-time
	fi
}


function lo() {
	# copyright 2007 - 2010 Christopher Bratusek
	if [[ "$@" == "" ]]; then
		$@="*"
	fi
	ls -l --group-directories-first "$@" | gawk '{print $9, "belongs to User ->", $3}' | sed -e '1d' | column -t
}


function l1() {
	# copyright 2007 - 2010 Christopher Bratusek
	ls -1 --group-directories-first "$@"
}



function lm() {
	# copyright 2007 - 2010 Christopher Bratusek
	if [[ ! "$@" == "" ]]; then
		for file in "$@"; do
			stat -c "%A %a %n" "$file" | gawk '{print "Permissions of:", $3, "->", $1, "("$2")"}'
		done | column -t
	fi
}

###### inspired by http://tldp.org/HOWTO/Bash-Prompt-HOWTO/x279.html
# but I made it a single awk instead of an awk, forloop and a bc
# asumes we have awk available.  but really, who doesnt have awk?
# let's get the size of the files in this dir
function lsbytes() {
    echo -n $(ls -l | awk '/^-/{total += $5} END{printf "%.2f", total/1048576}')
}



function lscd() {
	# copyright 2007 - 2010 Christopher Bratusek
	builtin cd "${@}" &>/dev/null
	. $BSNG_RC_DIR/dirinfo/display
	dirinfo_display
	echo -e "${epink}content:"
	ls $LSCD_OPTS
	echo "$PWD" > $HOME/.lastpwd
}

##################################################
# Create a new script, automatically populating  #
# 	the shebang line, editing the script, and 	 #
# 			making it executable.				 #
##################################################

function shebang() { if i=$(which $1); then printf '#!%s\n\n' $i >  $2 && edi + $2 && chmod 755 $2; else echo "'which' could not find $1, is it in your \$PATH?"; fi; }

##################################################
# Create an easy to pronounce shortened URL from #
# 						CLI						 #
##################################################

function shout() { curl -s "http://shoutkey.com/new?url=$1" | sed -n 's/\<h1\>/\&/p' | sed 's/<[^>]*>//g;/</N;//b' ;}

##################################################
#		 Switch two files (comes in handy)		 #
##################################################

function switchfile() {
mv $1 ${1}.tmp && $2 $1 && mv ${1}.tmp $2
}

##################################################
# 			Creates a dated tarball				 #
##################################################

function tarball()
{
    name=$1
    shift
    tar zcvf $name-`date +%Y%m%d`.tar.gz "$@"
}

##################################################
# 	Changes spaces to underscores in names		 #
##################################################

function underscore()
{
	for f in * ; do
    	[ "${f}" != "${f// /_}" ]
		mv -- "${f}" "${f// /_}"
	done
}

##################################################
# 	Move all files in current directory 		 #
# 			(recursively) up a level			 #
##################################################

function upalevel()
{
find . -type f | perl -pe '(s!(\./.*/)(.*)!mv "\1\2" "\1../\2"!);' | sh
}

##################################################
#                Mac specific:					 #
##################################################

# cdf:  'Cd's to frontmost window of MacOS Finder
    cdf () {
        currFolderPath=$( /usr/bin/osascript <<EOT
            tell application "Finder"
                try
            set currFolder to (folder of the front window as alias)
                on error
            set currFolder to (path to desktop folder as alias)
                end try
                POSIX path of currFolder
            end tell
EOT
        )
        echo "cd to \"$currFolderPath\""
        cd "$currFolderPath"
    }
    
##################################################
#	 Removing all extended attributes from a	 #
# 				directory tree					 #
##################################################

function rr()
{
    for i in $(ls -Rl@ | grep '^    ' | awk '{print $1}' | sort -u); \
       do echo Removing $i ... >&2;  \
       find . | xargs xattr -d $i 2>/dev/null ; done
}

