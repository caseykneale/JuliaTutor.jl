greet() = print("Hi my name is JuliaTutor, \n
                Here you can learn interactively through pre-made lessons.")

function inform(query)
    println( Crayon(foreground = :blue, bold = true), "> ",
             Crayon(foreground = :white, bold = false), query)
    println( Crayon(foreground = :blue, italics = true), "...Press any key to continue...")
    userinput = readline()
    exit_attempt(userinput) && exit()
end

function request_read_evaluate(request, var, answer)
    print( Crayon( foreground = :red, bold = true ), "> " )
    println( Crayon( foreground = :white, bold = false ), request, "\n" )
    correct = false
    while !correct
        print( Crayon( foreground = :green, italics = false ), "> " )
        userinput = readline()
        #userinput = strip_whitespace(userinput)
        exit_attempt(userinput) && exit()
        (syntax_error, incorrect_answer) = evaluate(userinput, var, answer)
        if syntax_error
            println(Crayon( foreground = :white, italics = true ), "🔧 Sorry it appears there is a syntax error in your code. Please try again!")
        elseif incorrect_answer
            println(Crayon( foreground = :white, italics = true ), "⅁ Good try but, this isn't the answer we are looking for. Please try again.")
        end
        correct = !syntax_error && !incorrect_answer
    end
    println(Crayon( foreground = :blue, italics = true ), "✔ Good job!" )
end

function request_read_evaluate(request, answer)
    print( Crayon( foreground = :red, bold = true ), "> ")
    println( Crayon( foreground = :white, bold = false ), request, "\n")
    correct = false
    while !correct
        print( Crayon( foreground = :green, italics = false ), "> ")
        userinput = readline()
        #userinput = strip_whitespace(userinput)
        exit_attempt(userinput) && exit()
        (syntax_error, incorrect_answer) = evaluate(userinput, answer)
        if syntax_error
            println(Crayon( foreground = :white, italics = true ), "🔧 Sorry it appears there is a syntax error in your code. Please try again!")
        elseif incorrect_answer
            println(Crayon( foreground = :white, italics = true ), "⅁ Good try but, this isn't the answer we are looking for. Please try again.")
        end
        correct = !syntax_error && !incorrect_answer
    end
    println(Crayon( foreground = :blue, italics = true ), "✔ Good job!" )
end
