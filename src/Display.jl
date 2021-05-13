greet() = println("Hi my name is JuliaTutor, \n
                Here you can interactively learn Julia through pre-made lessons.")

"""
    inform(query)

A convenience function to display long blocks to text to an end user.
"""
function inform(query)
    println( Crayon(foreground = :blue, bold = true), "> ",
             Crayon(foreground = :white, bold = false), query)
end

function request(request)
    print( Crayon( foreground = :red, bold = true ), "> " )
    println( Crayon( foreground = :white, bold = false ), request, "\n" )
end