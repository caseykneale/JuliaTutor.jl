greet() = println("Hi my name is JuliaTutor, \n
                Here you can interactively learn Julia through pre-made lessons.")

"""
    inform(query)

A convenience function to display long blocks to text to an end user.
"""
function inform(lesson::Lesson)
    print( Crayon(foreground = :blue, bold = true), "\n> ",
             Crayon(foreground = :white, bold = false), lesson.prompt)
end

function request(lesson::Lesson)
    print( Crayon( foreground = :red, bold = true ), "\n> " )
    print( Crayon( foreground = :white, bold = false ), lesson.request )
end

function help()
    println( "Enter `)` to exit or enter the tutor REPL." )
    println( "Ctrl + `c` will also exit the tutor REPL." )
    println( "Ctrl + `d` will end the REPL instance." )
end