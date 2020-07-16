module JuliaTutor
    using Crayons

    greet() = print("Hi my name is JuliaTutor, \n
                    Here you can learn interactively through pre-made lessons.")

    exit_attempt(ui) = lowercase(ui[1:min(4,length(ui))]) == "exit"
    strip_whitespace(ui) = filter(x -> !isspace(x), ui)

    function inform(query)
        println( Crayon(foreground = :blue, bold = true),
                 "> ",
                 Crayon(foreground = :white, bold = false),
                 query)
        println( Crayon(foreground = :blue, italics = true),
                 "...Press any key to continue...")
        userinput = readline()
        exit_attempt(userinput) && exit()
    end

    function evaluate(ui, ans)::Tuple{ Bool, Bool }
        #try to run the users code
        syntax_error,incorrect_answer = false, false;
        try
            println( include_string( Base, ui ) )
        catch
            syntax_error = true;
        end
        incorrect_answer = !(ui == ans)
        return (syntax_error, incorrect_answer)
    end

    function request_read_evaluate(request, answer)
        print( Crayon( foreground = :red, bold = true ),
                 "> ")
        println( Crayon( foreground = :white, bold = false ),
                 request )
        println(" ")
        correct = false
        while !correct
            print( Crayon( foreground = :green, italics = false ), "> ")
            userinput = readline()
            #userinput = strip_whitespace(userinput)
            exit_attempt(userinput) && exit()
            (syntax_error, incorrect_answer) = evaluate(userinput, answer)
            if syntax_error
                println(Crayon( foreground = :white, italics = true ),
                        "Sorry it appears there is a syntax error in your code.")
            elseif incorrect_answer
                println(Crayon( foreground = :white, italics = true ),
                        "Good try but, this isn't the answer we are looking for. Please try again.")
            end
            correct = !syntax_error && !incorrect_answer
        end
    end

    export inform, request_read_evaluate, evaluate

end # module
