# colored_echo (cEcho)
a pseudo-command intended to expand "echo's" color capability in BATCH.

The idea is to provide batch (using batch) with coloring-capabilities

_Current Version:_

> cEcho.bat v0.0.12

###here is a help reference for usage:

_\*this can be found from ```cEcho.bat -help```_
```
cEcho is used for coloring text 
*it requires an _even numbered_ amount of arguments to run correctly

cEcho references:
cEcho -help [argument]  :  [function]
                   -s   :  syntax
                   -a   :  argument pair syntax
                   -c   :  color reference
```

_\*this can be found from ```cEcho.bat -help -s```_
```
cEcho syntax is: cEcho [argument_pair1[ argument_pair2[ ...]]]
look at cEcho -help -a for argument pair syntax
```

_\*this can be found from ```cEcho.bat -help -a```_
```
argument pairs use syntax [text_to_colorize] [color_code]
look at cEcho -help -c for color code reference
```

_\*this can be found from ```cEcho.bat -help -c```_
```
color codes have 2 characters: 1 for the background ($) and 1 for the text (#)
the syntax is simple: $#
here is a table of all available color codes
color  :  normal_code  :  bright_code
Black  :  0            :  8
Blue   :  1            :  9
Green  :  2            :  a
Aqua   :  3            :  b
Red    :  4            :  c
Purple :  5            :  d
Yellow :  6            :  e
White  :  7            :  f
```
