#!/usr/bin/env bash

# 📌 html_color_chart() - display color chart & command using tput ANSI commands
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
