module JuliaTutor
    using Crayons

    greet() = print("Hi my name is JuliaTutor, \n
                    Here you can learn interactively through pre-made lessons.")

    exit_attempt(ui) = lowercase(ui[1:min(4,length(ui))]) == "exit"

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

    function evaluate(ui, var, ans)::Tuple{ Bool, Bool }
        #try to run the users code
        syntax_error, incorrect_answer = false, false;
        ui_ex = Meta.parse(ui)
        try
            eval(ui_ex)
        catch
            syntax_error = true;
        end
        # check whether the variable is defined
        try
            eval(var)
        catch
            incorrect_answer = true;
        end
        # if defined check whether it is set to the correct answer
        !incorrect_answer && (incorrect_answer = !(eval(var) === ans))
        return (syntax_error, incorrect_answer)
    end

    function request_read_evaluate(request, var, answer)
        print( Crayon( foreground = :red, bold = true ),
                 "> ")
        println( Crayon( foreground = :white, bold = true ),
                 request )
        println(" ")
        correct = false
        while !correct
            print( Crayon( foreground = :green ), "> ")
            userinput = readline()
            exit_attempt(userinput) && exit()
            (syntax_error, incorrect_answer) = evaluate(userinput, var, answer)
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
