#!/usr/bin/env bash

# 📌 html_colors - display color with HTML hex numbers
# ------------------------------------------------------------------------------
html_color(){
    dec=$(($1%256))   ### input must be a number in range 0-255.
    foreground="15";
    if [ "$dec" -lt "16" ]; then
        [[ ${1} ==  7 ]] && foreground="0"; [[ ${1} == 15 ]] && foreground="0";
        bas=$(( dec%16 )); mul=128;
        [ "$bas" -eq "7" ] && mul=192
        [ "$bas" -eq "8" ] && bas=7
        [ "$bas" -gt "8" ] && mul=255
        a="$((  (bas&1)    *mul ))"; b="$(( ((bas&2)>>1)*mul ))";  c="$(( ((bas&4)>>2)*mul ))";
        tput setaf 7; printf ' %3s: ' "$dec"; tput setaf ${foreground}; tput setab $dec; printf '#%02x%02x%02x' "$a" "$b" "$c";
        tput setaf $dec; tput sgr0; printf " ";
    elif [ "$dec" -gt 15 ] && [ "$dec" -lt 232 ]; then
        b=$(( (dec-16)%6  )); b=$(( b==0?0: b*40 + 55 ))
        g=$(( (dec-16)/6%6)); g=$(( g==0?0: g*40 + 55 ))
        r=$(( (dec-16)/36 )); r=$(( r==0?0: r*40 + 55 ))
        tput setaf 7; printf ' %3s: ' "$dec"; tput setaf ${foreground}; tput setab $dec; printf '#%02x%02x%02x' "$r" "$g" "$b";
        tput setaf $dec; tput sgr0; printf " ";
    else
        [[ ${1} > 247 ]] && foreground="0";
        gray=$(( (dec-232)*10+8 ))
        tput setaf 7; printf ' %3s: ' "$dec"; tput setaf ${foreground}; tput setab $dec; printf '#%02x%02x%02x' "$gray" "$gray" "$gray";
        tput setaf $dec; tput sgr0; printf " ";
    fi
    return 0;
}

# 📌 term_color() - display color chart & command using tput ANSI commands
# ------------------------------------------------------------------------------
term_color() {
  [[ -z ${1}                ]] && { shift; ${FUNCNAME[0]} l ; return; }
  [[ "${1}" == "list"       ]] || [[ "${1}" == "l"  ]] && {  for i in $(seq 0 255); do html_color ${i}; done; printf "\n";  return; }
  [[ "${1}" == "foreground" ]] || [[ "${1}" == "fg" ]] && { shift; tput setaf ${1}; printf "${2}"; tput sgr0; printf "\n"; return; }
  [[ "${1}" == "background" ]] || [[ "${1}" == "bg" ]] && { shift; tput setab ${1}; printf "${2}"; tput setab 0; printf "\n"; return; }
  [[ "${1}" == "colors"     ]] || [[ "${1}" == "c"  ]] && { shift;
      ( x=`tput op` y=`printf %$((${COLUMNS}-6))s`; n="$(tput lines)";
        for i in {0..256};
          do { [[ "$i" == "$n" ]] && { n=$(( n + 34 )); pause; };
               o=00$i; echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;
          } done;
      )
      return;
  }
  [[ "${1}" == "?" ]] || [[ "${1}" == "-?" ]] || [[ "${1}" == "help" ]] || [[ "${1}" == "-h" ]] || [[ "${1}" == "?" ]] && {
    echo -e "
    PURPOSE: Load color code chart or individual colors

    ${FUNCNAME[0]} <none> | # | <command options>

    OPTIONS:
      <none>             - display chart of all colors with HTML hex # equivalent
      #                  - displayed color's # and show its color
      l  | list          - display color chart of HTML color codes
      fg | foreground #  - enter set foreground color specified
      bg | background #  - enter set background color specified
      ?  | help          - This help.
    "
    printf "\t\"tput colors\" available = "; tput colors;
    printf "\t\"tput setaf #\" to set freground color \n";
    printf "\t\"tput setab #\" to set background color\n";
    printf "\t\"tput sgr0\" to turn off all attributes\n";
    printf "\n"
    return;
  }
  [[ "${1}" != ""   ]] && { html_color ${1}; printf "\n"; return; }
  }
