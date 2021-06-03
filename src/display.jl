"""
    greet()

Greets the user the first time they run JuliaTutor.
"""
greet() = println("Hi my name is JuliaTutor, \n
                Here you can interactively learn Julia through pre-made lessons.")

"""
    inform(lesson::Lesson)

A convenience function to display the prompt of a lesson to an end user.
"""
function inform(lesson::Lesson)
    print( Crayon(foreground = :blue, bold = true), "\n> ",
             Crayon(foreground = :white, bold = false), lesson.prompt)
end

"""
    request(lesson::Lesson)

A convenience function to display what action is requested for an end user to accomplish.
"""
function request(lesson::Lesson)
    print( Crayon( foreground = :red, bold = true ), "\n> " )
    print( Crayon( foreground = :white, bold = false ), lesson.request )
end

"""
    hint(lesson::Lesson)

Displays a hint for the user, if the lesson provides it. Otherwise - it directs the user to Discourse.
"""
function hint(lesson::Lesson)
    if length(lesson.hint) == 0
        print( Crayon( foreground = :red, italics = true ), """
        Sorry... No hints were given for this lesson. 
        You can always check in with the Humans Of Julia Discord for assistance: 
        https://discord.com/channels/762167454973296644/822525930579689552
        """ )
    else
        print( Crayon( foreground = :blue, italics = true ), "\n " * lesson.hint )
    end
    print( Crayon( foreground = :white, italics = false ), "\n" )
end

"""
    help()

Displays generic tips for how to navigate JuliaTutor.
"""
function help()
    println( "Enter `)` to exit or enter the tutor REPL." )
    println( "Ctrl + `c` will also exit the tutor REPL." )
    println( "Ctrl + `d` will end the REPL instance." )
    println( "Type `hint` to see if the author provided hints for a lesson." )
end