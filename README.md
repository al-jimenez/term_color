# term_color()
This is a simple function that displays a chart of colors and/or will display a color given a number.

## Use
Use this and customize it with your changes. I use this as a menu of colors since my old man brain cannot remember the color number for a specific color.

## OS
Used / created for macOS bash but can be modified for other OS.

## Help menu
When you execute term_color -? you will get the following:
![Help menu](https://github.com/al-jimenez/term_color/blob/master/term_color_help.png)

## With no options
![without options](https://github.com/al-jimenez/term_color/blob/master/term_colors.png)

## Usage Examples

    term_color -?  -  to get the help menu

    term_color <date string> - i.e.: term_color "%I:%M %p, %D" returns >> 10:15 AM, 07/17/20

    Script usage: <variable name>=$(echo "$(term_color fs)")

    Script usage: echo "$(term_color dd/mm/yy)"
