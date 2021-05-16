#This is just codegen for making some convenient names for commonly used fonts.
#don't remmember if this is in use or not anymore...

cols = "black, red, green, yellow, blue, magenta, cyan, light_gray, default, dark_gray, light_red, light_green, light_yellow, light_blue, light_magenta, light_cyan, white"
fxs = "reset, bold, faint, italics, underline, blink, negative, conceal, strikethrough"

for (col, fx) in Iterators.product( split(cols, ", "), split(fxs, ", ") )
    name = Symbol(col * "_" * fx)
    global colsym = Symbol( col )
    global fxsym = Symbol( fx )
    @eval $colsym = colsym
    @eval $fxsym = fxsym
    @eval $name() = Crayon( foreground = $colsym, $fxsym = true)
end
