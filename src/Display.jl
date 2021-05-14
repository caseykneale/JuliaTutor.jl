greet() = println("Hi my name is JuliaTutor, \n
                Here you can interactively learn Julia through pre-made lessons.")

"""
    inform(query)

A convenience function to display long blocks to text to an end user.
"""
function inform(lesson::Lesson)
    println( Crayon(foreground = :blue, bold = true), "> ",
             Crayon(foreground = :white, bold = false), lesson.prompt)
end

function request(lesson::Lesson)
    print( Crayon( foreground = :red, bold = true ), "> " )
    println( Crayon( foreground = :white, bold = false ), lesson.request, "\n" )
end