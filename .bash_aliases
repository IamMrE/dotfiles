##### This is the Mac version... #####

##################################################
#                Mac specific:					 #
##################################################
# show hidden files in Finder
alias showFiles='defaults write com.apple.finder AppleShowAllFiles -bool YES && killall Finder'										
# hide (normally) hidden files in Finder
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles -bool NO && killall Finder'										
# because I've typed 'diskutil list' 10K x...
alias list='diskutil list'


##################################################
#        Terminal Navigation & Basics			 #
##################################################
alias ll='ls -CFGa'			    				# Preferred 'ls' implementation
alias cp='cp -iv'                          		# Preferred 'cp' implementation
alias mv='mv -iv'                           	# Preferred 'mv' implementation
alias rm='rm -iv'			    				# Preferred 'rm' implementation
alias mkdir='mkdir -pv'                     	# Preferred 'mkdir' implementation
mcd () { mkdir -p "$1" && cd "$1"; }        	# mcd: Makes new Dir and jumps inside
cd () { builtin cd "$@"; ll; }               	# Always list directory contents upon 'cd'
alias cd..='cd ../'                         	# Go back 1 directory level (for fast typers)
alias ..='cd ../'                           	# Go back 1 directory level
alias ...='cd ../../'                       	# Go back 2 directory levels
alias .3='cd ../../../'                     	# Go back 3 directory levels
alias .4='cd ../../../../'                  	# Go back 4 directory levels
alias .5='cd ../../../../../'               	# Go back 5 directory levels
alias .6='cd ../../../../../../'            	# Go back 6 directory levels
alias ~="cd ~"                              	# ~:            Go Home

##################################################
#                Permissions					 #
##################################################
	alias 000='chmod 000 -R'
	alias 640='chmod 640 -R'
	alias 644='chmod 644 -R'					# default permission for ('~/.dmrc' file)
	alias 755='chmod 755 -R'					# default permissions for $HOME (excluding '~/.dmrc' file)
	alias 775='chmod 775 -R'
	alias 777='chmod 777 -R'
	alias mx='chmod a+x'
	alias perm='stat --printf "%a %n \n "'		# requires a file name e.g. perm file
	alias permall='777'
	alias permhome='chmod 755 -R $HOME && chmod 644 $HOME/.dmrc'
												# restore user,group and mod of an entire website
	alias restoremod='chgrp users -R .;chmod u=rwX,g=rX,o=rX -R .;chown $(pwd |cut -d / -f 3) -R .'																	
	
												# lr:  Full Recursive Directory Listing
   alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'	
	
##################################################
#  				lots of ls options...			 #
##################################################

alias llll='ls -laS --color=auto'							# sort by size
alias lll='ls -Falot --color=auto'							# sort by mod time
alias ll_='ls -l'											# long listing
alias l.='ls -d .[[:alnum:]]* 2> /dev/null || echo "No hidden file here..."'		# list only hidden files
alias l='ls -hF --color'									# quick listing
alias lm_='ls -al |more'    								# pipe through 'more'
alias ln='ln -s'
alias lr='ls -lR'											# recursive ls
alias lrt='ls -lart'										# list files with last modified at the end
alias lsam='ls -am' 										# List files horizontally
alias lsdd='ls -latr'                                 					# sort by date
alias lsd='ls -l | grep "^d"'								# list only directories
alias lsize='ls --sort=size -lhr'							# list by size
alias lsl='ls -lah'                                   		# long list, human-readable
alias ls='ls -hF --color'									# add colors for filetype recognition
alias lsnew='ls -Alh --color=auto --time-style=+%D | grep `date +%D`'
alias lss='ls -shaxSr'                         			    # sort by size
alias lsss='ls -lrt | grep $1'								# to see something coming into ls output: lss
alias lsx='ls -ax' 											# sort right to left rather then in columns
alias lt_='ls -alt|head -20' 								# 20, all, long listing, modification time
alias lt='ls -ltr'         									# sort by date, most recent last
alias lu='ls -ltur'        									# sort by and show access time, most recent last
alias lx='ls -lXB'											# sort by extension
__setprompt () 
{ 
    last_command=$?;
    red="\033[38;05;124m";
    grn="\033[38;05;2m";
    yel="\033[38;05;3m";
    blu="\033[38;05;4m";
    pnk="\033[38;05;5m";
    cya="\033[38;05;6m";
    wht="\033[38;05;7m";
    gry="\033[38;05;8m";
    ired="\033[38;05;9m";
    igrn="\033[38;05;46m";
    iyel="\033[38;05;11m";
    iblu="\033[38;05;12m";
    ipnk="\033[38;05;13m";
    icya="\033[38;05;14;1m";
    iwht="\033[38;05;15m";
    igry="\033[38;05;16m";
    iorg="\033[38;5;208m";
    purp="\033[38;05;4m";
    dpur="\033[38;05;4;1m";
    ipur="\033[38;05;4m";
    bpur="\033[38;05;4;1m";
    mgrn="\033[38;05;28m";
    bgrn="\033[38;05;10;1m";
    borg="\033[38;5;208;1m";
    bpnk="\033[38;5;165;1m";
    rset="\033[0m";
    let fillsize=${COLUMNS}-12;
    fill="";
    while [ "$fillsize" -gt "0" ]; do
        fill="-${fill}";
        let fillsize=${fillsize}-1;
    done;
    if [[ $last_command != 0 ]]; then
        PS1="\[${red}\]😡  $fill \@\n\[${gry}\][\[${red}\]Error \[${ired}\]${last_command}\[${gry}\]]-[\[${red}\]";
        if [[ $last_command == 1 ]]; then
            PS1+="General error";
        else
            if [ $last_command == 2 ]; then
                PS1+="Missing keyword, command, or permission problem";
            else
                if [ $last_command == 126 ]; then
                    PS1+="Permission problem or command is not an executable";
                else
                    if [ $last_command == 127 ]; then
                        PS1+="Command not found";
                    else
                        if [ $last_command == 128 ]; then
                            PS1+="Invalid argument to exit";
                        else
                            if [ $last_command == 129 ]; then
                                PS1+="Fatal error signal 1";
                            else
                                if [ $last_command == 130 ]; then
                                    PS1+="Script terminated by Control-C";
                                else
                                    if [ $last_command == 131 ]; then
                                        PS1+="Fatal error signal 3";
                                    else
                                        if [ $last_command == 132 ]; then
                                            PS1+="Fatal error signal 4";
                                        else
                                            if [ $last_command == 133 ]; then
                                                PS1+="Fatal error signal 5";
                                            else
                                                if [ $last_command == 134 ]; then
                                                    PS1+="Fatal error signal 6";
                                                else
                                                    if [ $last_command == 135 ]; then
                                                        PS1+="Fatal error signal 7";
                                                    else
                                                        if [ $last_command == 136 ]; then
                                                            PS1+="Fatal error signal 8";
                                                        else
                                                            if [ $last_command == 137 ]; then
                                                                PS1+="Fatal error signal 9";
                                                            else
                                                                if [ $last_command -gt 255 ]; then
                                                                    PS1+="Exit status out of range";
                                                                else
                                                                    PS1+="Unknown error code";
                                                                fi;
                                                            fi;
                                                        fi;
                                                    fi;
                                                fi;
                                            fi;
                                        fi;
                                    fi;
                                fi;
                            fi;
                        fi;
                    fi;
                fi;
            fi;
        fi;
        PS1+="\[${gry}\]]\[${rset}\] try again? \n";
    else
        PS1="\[${grn}\]😎  $fill \@";
    fi;
    SSH_IP=`echo $SSH_CLIENT | awk '{ print $1 }'`;
    SSH2_IP=`echo $SSH2_CLIENT | awk '{ print $1 }'`;
    if [ $SSH2_IP ] || [ $SSH_IP ]; then
        PS1+="\[${bgrn}\]\u\[${rset}\] (remote) on ";
    else
        PS1+="\[${bpur}\]\u\[${rset}\] is on ";
    fi;
    PS1+="\[${borg}\]\h\[${rset}\]";
    PS1+="\[${rset}\] in \[${iyel}\]\w\[${rset}\] which has";
    PS1+="\[${icya}\]\[$(/bin/ls -A -1 | /usr/bin/wc -l)\[${rset}\] files using ";
    PS1+="\[${icya}\]$(/bin/ls -lah | /usr/bin/grep -m 1 total | /usr/bin/sed 's/total //')K\[${gry}\]";
    PS1+="\n";
    if [[ $EUID -ne 0 ]]; then
        PS1+="\[${grn}\]=> \[${rset}\]";
    else
        PS1+="\[${ired}\]=> \[${rset}\]";
    fi;
    PS2="\[${gry}\]>\[${rset}\] ";
    PS3='Please enter a number from above list: ';
    PS4='\[${gry}\]+\[${rset}\] ';
    trap 'echo -ne "\033[0m"' DEBUG
}
addalias () 
{ 
    declare -f $1 >> ~/.bash_aliases
}
addfunction () 
{ 
    declare -f $1 >> ~/.bash_functions
}
append () 
{ 
    lastarg="${!#}";
    echo "${@:1:$(($#-1))}" >> "$lastarg"
}
arabic2roman () 
{ 
    echo $1 | sed -e 's/1...$/M&/;s/2...$/MM&/;s/3...$/MMM&/;s/4...$/MMMM&/
s/6..$/DC&/;s/7..$/DCC&/;s/8..$/DCCC&/;s/9..$/CM&/
s/1..$/C&/;s/2..$/CC&/;s/3..$/CCC&/;s/4..$/CD&/;s/5..$/D&/
s/6.$/LX&/;s/7.$/LXX&/;s/8.$/LXXX&/;s/9.$/XC&/
s/1.$/X&/;s/2.$/XX&/;s/3.$/XXX&/;s/4.$/XL&/;s/5.$/L&/
s/1$/I/;s/2$/II/;s/3$/III/;s/4$/IV/;s/5$/V/
s/6$/VI/;s/7$/VII/;s/8$/VIII/;s/9$/IX/
s/[0-9]//g'
}
asc2all () 
{ 
    if [[ -n $1 ]]; then
        echo "ascii $1 = binary $(asc2bin $1)";
        echo "ascii $1 = octal $(asc2oct $1)";
        echo "ascii $1 = decimal $(asc2dec $1)";
        echo "ascii $1 = hexadecimal $(asc2hex $1)";
        echo "ascii $1 = base32 $(asc2b32 $1)";
        echo "ascii $1 = base64 $(asc2b64 $1)";
    fi
}
asc2b32 () 
{ 
    if [[ -n $1 ]]; then
        echo "obase=32 ; $(asc2dec $1)" | bc;
    fi
}
asc2b64 () 
{ 
    if [[ -n $1 ]]; then
        echo "obase=64 ; $(asc2dec $1)" | bc;
    fi
}
asc2bin () 
{ 
    if [[ -n $1 ]]; then
        echo "obase=2 ; $(asc2dec $1)" | bc;
    fi
}
asc2dec () 
{ 
    if [[ -n $1 ]]; then
        printf '%d\n' "'$1'";
    fi
}
asc2hex () 
{ 
    if [[ -n $1 ]]; then
        echo "obase=16 ; $(asc2dec $1)" | bc;
    fi
}
asc2oct () 
{ 
    if [[ -n $1 ]]; then
        echo "obase=8 ; $(asc2dec $1)" | bc;
    fi
}
cd () 
{ 
    builtin cd "$@";
    ls -CFGa
}
cdf () 
{ 
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
        );
    echo "cd to \"$currFolderPath\"";
    cd "$currFolderPath"
}
cel2fah () 
{ 
    if [[ -n $1 ]]; then
        echo "scale=2; $1 * 1.8  + 32" | bc;
    fi
}
colorize-text () 
{ 
    b='[0;30m';
    while getopts "nr" opt; do
        case $opt in 
            n)
                o='-n'
            ;;
            r)
                b=''
            ;;
        esac;
    done;
    shift $(($OPTIND - 1));
    col=$1;
    shift;
    text="$*";
    case $col in 
        'black')
            a='[0;30m'
        ;;
        'blue')
            a='[0;34m'
        ;;
        'green')
            a='[0;32m'
        ;;
        'cyan')
            a='[0;36m'
        ;;
        'red')
            a='[0;31m'
        ;;
        'purple')
            a='[0;35m'
        ;;
        'brown')
            a='[0;33m'
        ;;
        'ltgray')
            a='[0;37m'
        ;;
        'white')
            a='[1;30m'
        ;;
        'ltblue')
            a='[1;34m'
        ;;
        'ltgreen')
            a='[1;32m'
        ;;
        'ltcyan')
            a='[1;36m'
        ;;
        'ltred')
            a='[1;31m'
        ;;
        'pink')
            a='[1;35m'
        ;;
        'yellow')
            a='[1;33m'
        ;;
        'gray')
            a='[1;37m'
        ;;
    esac;
    echo -en "\033$a$text";
    if [ -n $b ]; then
        echo -en "\033$b";
    fi;
    echo $o
}
colors () 
{ 
    esc="\033[";
    echo -e "\t  40\t   41\t   42\t    43\t      44       45\t46\t 47";
    for fore in 30 31 32 33 34 35 36 37;
    do
        line1="$fore  ";
        line2="    ";
        for back in 40 41 42 43 44 45 46 47;
        do
            line1="${line1}${esc}${back};${fore}m Normal  ${esc}0m";
            line2="${line2}${esc}${back};${fore};1m Bold    ${esc}0m";
        done;
        echo -e "$line1\n$line2";
    done;
    echo "";
    echo "# Example:";
    echo "#";
    echo "# Type a Blinkin TJEENARE in Swedens colours (Yellow on Blue)";
    echo "#";
    echo "#           ESC";
    echo "#            |  CD";
    echo "#            |  | CD2";
    echo "#            |  | | FG";
    echo "#            |  | | |  BG + m";
    echo "#            |  | | |  |         END-CD";
    echo "#            |  | | |  |            |";
    echo "# echo -e '\033[1;5;33;44mTJEENARE\033[0m'";
    echo "#";
    echo "# Sedika Signing off for now ;->"
}
colors2 () 
{ 
    T1=8;
    T2=6;
    T3=36;
    offset=0;
    for num1 in {0..7};
    do
        { 
            for num2 in {0,1};
            do
                { 
                    shownum=`echo "$offset + $T1 * ${num2} + $num1" | bc`;
                    echo -en "\E[0;48;5;${shownum}m color ${shownum} \E[0m"
                };
            done;
            echo
        };
    done;
    offset=16;
    for num1 in {0..5};
    do
        { 
            for num2 in {0..5};
            do
                { 
                    for num3 in {0..5};
                    do
                        { 
                            shownum=`echo "$offset + $T2 * ${num3}                  + $num2 + $T3 * ${num1}" | bc`;
                            echo -en "\E[0;48;5;${shownum}m color ${shownum} \E[0m"
                        };
                    done;
                    echo
                };
            done
        };
    done;
    offset=232;
    for num1 in {0..23};
    do
        { 
            shownum=`expr $offset + $num1`;
            echo -en "\E[0;48;5;${shownum}m ${shownum}\E[0m"
        };
    done;
    echo
}
colors2nums () 
{ 
    for code in {0..255};
    do
        echo -e "\033[38;05;${code}m $code: Test";
    done
}
compress_ () 
{ 
    FILE=$1;
    shift;
    case $FILE in 
        *.tar.bz2)
            tar cjf $FILE $*
        ;;
        *.tar.gz)
            tar czf $FILE $*
        ;;
        *.tgz)
            tar czf $FILE $*
        ;;
        *.zip)
            zip $FILE $*
        ;;
        *.rar)
            rar $FILE $*
        ;;
        *)
            echo "Filetype not recognized"
        ;;
    esac
}
cp_p () 
{ 
    if [ `echo "$2" | grep ".*\/$"` ]; then
        pv "$1" > "$2""$1";
    else
        pv "$1" > "$2"/"$1";
    fi
}
die () 
{ 
    result=$1;
    shift;
    [ -n "$*" ] && printf "%s\n" "$*" 1>&2;
    exit $result
}
err () 
{ 
    grep --recursive --color=auto --recursive -- "$@" /usr/include/*/errno.h;
    if [ "${?}" != 0 ]; then
        echo "Not found.";
    fi
}
fah2cel () 
{ 
    if [[ -n $1 ]]; then
        echo "scale=2 ; ( $1 - 32  ) / 1.8" | bc;
    fi
}
fix () 
{ 
    if [ -d $1 ]; then
        find $1 -type d -exec chmod 755 {} \;;
        find $1 -type f -exec chmod 644 {} \;;
    else
        echo "$1 is not a directory.";
    fi
}
forecast () 
{ 
    _ZIP=$1;
    if [ $# = 1 ]; then
        printf "$_ZIP\n" | egrep '^[0-9][0-9][0-9][0-9][0-9]$' >> /dev/null;
        if [ $? = 0 ]; then
            printf "Your 10 Day Weather Forecast as follows:\n";
            lynx -dump "http://www.weather.com/weather/print/$_ZIP" | sed -n '/%$/s/\[.*\]//p';
            printf "\n";
        else
            if [ $? = 1 ]; then
                printf "Bad ZIP code!\n";
            fi;
        fi;
    else
        if [ $# != 1 ]; then
            printf "You need to supply a ZIP code!\n";
        fi;
    fi
}
hourglass () 
{ 
    s=$(($SECONDS +${1:-10}));
    ( tput civis;
    while [[ $SECONDS -lt $s ]]; do
        for f in '|' ' ' '\-' /;
        do
            echo -n $f && sleep .2s && tput cub1;
        done;
    done );
    tput cnorm
}
l1 () 
{ 
    ls -hF --color -1 --group-directories-first "$@"
}
la () 
{ 
    ls -hF --color -A --group-directories-first "$@"
}
lg () 
{ 
    if [[ "$@" == "" ]]; then
        $@="*";
    fi;
    ls -hF --color -l --group-directories-first "$@" | gawk '{print $9, "belongs to Group ->", $4}' | column -t
}
# ll () 
# { 
#     ls -hF --color -l --group-directories-first "$@"
# }
lls () 
{ 
    echo -n "<`find . -maxdepth 1 -mindepth 1 -type f | wc -l | tr -d '[:space:]'` files>";
    echo -n " <`find . -maxdepth 1 -mindepth 1 -type d | wc -l | tr -d '[:space:]'` dirs/>";
    echo -n " <`find . -maxdepth 1 -mindepth 1 -type l | wc -l | tr -d '[:space:]'` links@>";
    echo " <~`du -sh . 2> /dev/null | cut -f1`>";
    ROWS=`stty size | cut -d' ' -f1`;
    FILES=`find . -maxdepth 1 -mindepth 1 |
	wc -l | tr -d '[:space:]'`;
    if [ `expr "${ROWS}" - 6` -lt "${FILES}" ]; then
        ls -hF --color;
    else
        ls -hF --color -hlAF --full-time;
    fi
}
lm () 
{ 
    if [[ ! "$@" == "" ]]; then
        for file in "$@";
        do
            stat -c "%A %a %n" "$file" | gawk '{print "Permissions of:", $3, "->", $1, "("$2")"}';
        done | column -t;
    fi
}
lo () 
{ 
    if [[ "$@" == "" ]]; then
        $@="*";
    fi;
    ls -hF --color -l --group-directories-first "$@" | gawk '{print $9, "belongs to User ->", $3}' | sed -e '1d' | column -t
}
lsbytes () 
{ 
    echo -n $(ls -l | awk '/^-/{total += $5} END{printf "%.2f", total/1048576}')
}
lscd () 
{ 
    builtin cd "${@}" >&/dev/null;
    . $BSNG_RC_DIR/dirinfo/display;
    dirinfo_display;
    echo -e "${epink}content:";
    ls -hF --color $LSCD_OPTS;
    echo "$PWD" > $HOME/.lastpwd
}
mcd () 
{ 
    mkdir -pv -p "$1" && cd "$1"
}
phone2text () 
{ 
    echo -n "Enter number: ";
    read num;
    num="${num//2/{a,b,c\}}";
    num="${num//3/{d,e,f\}}";
    num="${num//4/{g,h,i\}}";
    num="${num//5/{j,k,l\}}";
    num="${num//6/{m,n,o\}}";
    num="${num//7/{p,q,r,s\}}";
    num="${num//8/{t,u,v\}}";
    num="${num//9/{w,x,y,z\}}";
    num="${num//\\/}";
    echo "";
    echo "Possible words are:";
    for word in $( eval echo "$num" );
    do
        echo '>' "$word";
    done
}
progressbar () 
{ 
    SP_COLOUR="\e[37;44m";
    SP_WIDTH=5.5;
    SP_DELAY=0.2;
    SP_STRING=${2:-"'|/=\'"};
    while [ -d /proc/$1 ]; do
        printf "$SP_COLOUR\e7  %${SP_WIDTH}s  \e8\e[01;37m" "$SP_STRING";
        sleep ${SP_DELAY:-.2};
        SP_STRING=${SP_STRING#"${SP_STRING%?}"}${SP_STRING%?};
    done;
    tput sgr0
}
rr () 
{ 
    for i in $(ls -Rl@ | grep '^    ' | awk '{print $1}' | sort -u);
    do
        echo Removing $i ... 1>&2;
        find . | xargs xattr -d $i 2> /dev/null;
    done
}
shebang () 
{ 
    if i=$(which $1); then
        printf '#!%s\n\n' $i > $2 && vim + $2 && chmod 755 $2;
    else
        echo "'which' could not find $1, is it in your \$PATH?";
    fi
}
shout () 
{ 
    curl -s "http://shoutkey.com/new?url=$1" | sed -n 's/\<h1\>/\&/p' | sed 's/<[^>]*>//g;/</N;//b'
}
spanner () 
{ 
    PROC=$1;
    COUNT=0;
    echo -n "Please wait ";
    while [ -d /proc/$PROC ]; do
        while [ "$COUNT" -lt 10 ]; do
            echo -ne '\x08  ';
            sleep 0.1;
            ((COUNT++));
        done;
        until [ "$COUNT" -eq 0 ]; do
            echo -ne '\x08\x08 ';
            sleep 0.1;
            ((COUNT -= 1));
        done;
    done
}
spin () 
{ 
    echo -n "|/     |";
    while [ -d /proc/$1 ]; do
        echo -ne "\b\b\b\b\b\b\b-     |";
        sleep .05;
        echo -ne "\b\b\b\b\b\b\b\\     |";
        sleep .05;
        echo -ne "\b\b\b\b\b\b\b|     |";
        sleep .05;
        echo -ne "\b\b\b\b\b\b\b /    |";
        sleep .05;
        echo -ne "\b\b\b\b\b\b-    |";
        sleep .05;
        echo -ne "\b\b\b\b\b\b\\    |";
        sleep .05;
        echo -ne "\b\b\b\b\b\b|    |";
        sleep .05;
        echo -ne "\b\b\b\b\b\b /   |";
        sleep .05;
        echo -ne "\b\b\b\b\b-   |";
        sleep .05;
        echo -ne "\b\b\b\b\b\\   |";
        sleep .05;
        echo -ne "\b\b\b\b\b|   |";
        sleep .05;
        echo -ne "\b\b\b\b\b /  |";
        sleep .05;
        echo -ne "\b\b\b\b-  |";
        sleep .05;
        echo -ne "\b\b\b\b\\  |";
        sleep .05;
        echo -ne "\b\b\b\b|  |";
        sleep .05;
        echo -ne "\b\b\b\b / |";
        sleep .05;
        echo -ne "\b\b\b- |";
        sleep .05;
        echo -ne "\b\b\b\\ |";
        sleep .05;
        echo -ne "\b\b\b| |";
        sleep .05;
        echo -ne "\b\b\b /|";
        sleep .05;
        echo -ne "\b\b-|";
        sleep .05;
        echo -ne "\b\b\\|";
        sleep .05;
        echo -ne "\b\b||";
        sleep .05;
        echo -ne "\b\b/|";
        sleep .05;
        echo -ne "\b\b||";
        sleep .05;
        echo -ne "\b\b\\|";
        sleep .05;
        echo -ne "\b\b-|";
        sleep .05;
        echo -ne "\b\b\b/ |";
        sleep .05;
        echo -ne "\b\b\b| |";
        sleep .05;
        echo -ne "\b\b\b\\ |";
        sleep .05;
        echo -ne "\b\b\b- |";
        sleep .05;
        echo -ne "\b\b\b\b/  |";
        sleep .05;
        echo -ne "\b\b\b\b|  |";
        sleep .05;
        echo -ne "\b\b\b\b\\  |";
        sleep .05;
        echo -ne "\b\b\b\b-  |";
        sleep .05;
        echo -ne "\b\b\b\b\b/   |";
        sleep .05;
        echo -ne "\b\b\b\b\b|   |";
        sleep .05;
        echo -ne "\b\b\b\b\b\\   |";
        sleep .05;
        echo -ne "\b\b\b\b\b-   |";
        sleep .05;
        echo -ne "\b\b\b\b\b\b/    |";
        sleep .05;
        echo -ne "\b\b\b\b\b\b|    |";
        sleep .05;
        echo -ne "\b\b\b\b\b\b\\    |";
        sleep .05;
        echo -ne "\b\b\b\b\b\b-    |";
        sleep .05;
        echo -ne "\b\b\b\b\b\b\b/     |";
        sleep .05;
    done;
    echo -e "\b\b\b\b\b\b\b\b\b|=======| done!"
}
spinner () 
{ 
    PROC=$1;
    while [ -d /proc/$PROC ]; do
        echo -ne '\e[01;32m/\x08';
        sleep 0.05;
        echo -ne '\e[01;32m-\x08';
        sleep 0.05;
        echo -ne '\e[01;32m\\\x08';
        sleep 0.05;
        echo -ne '\e[01;32m|\x08';
        sleep 0.05;
    done
}
spinner2 () 
{ 
    local action=${1:-"start"};
    declare -a sign=("-" "/" "|" "\\\\");
    [ "$action" = "start" ] && echo 1 > /tmp/signal;
    [ "$action" = "stop" ] && echo 0 > /tmp/signal;
    while [ "$( cat /tmp/signal 2>/dev/null )" == "1" ]; do
        for ((i=0; i<${#sign[@]}; i++ ))
        do
            echo -en "${sign[$i]}\b";
            perl -e 'select( undef, undef, undef, 0.1 );';
        done;
    done;
    [ "$action" = "stop" ] && echo -ne " \b"
}
suntimes () 
{ 
    l=12765843;
    curl -s http://weather.yahooapis.com/forecastrss?w=$l | grep astronomy | awk -F\" '{print $2 "\n" $4;}'
}
switchfile () 
{ 
    mv -iv $1 ${1}.tmp && $2 $1 && mv -iv ${1}.tmp $2
}
tarball () 
{ 
    name=$1;
    shift;
    tar zcvf $name-`date +%Y%m%d`.tar.gz "$@"
}
uncolorpdf () 
{ 
    convert -density 300 "$1" -fill "rgb(255,255,255)" -opaque "rgb(0,0,0)" "$2"
}
underscore () 
{ 
    for f in *;
    do
        [ "${f}" != "${f// /_}" ];
        mv -iv -- "${f}" "${f// /_}";
    done
}
upalevel () 
{ 
    find . -type f | perl -pe '(s!(\./.*/)(.*)!mv "\1\2" "\1../\2"!);' | sh
}
weather_ () 
{ 
    declare -a WEATHERARRAY;
    WEATHERARRAY=(`lynx -dump http://google.com/search?q=weather+$1 | grep -A 5 '^ *Weather for' | grep -v 'Add to'`);
    echo ${WEATHERARRAY[@]}
}
