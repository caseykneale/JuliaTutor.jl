greet() = print("Hi my name is JuliaTutor, \n
                Here you can learn interactively through pre-made lessons.")

"""
    inform(query)

A convenience function to display long blocks to text to an end user.
"""
function inform(query, wait_for_key = true)
    println( Crayon(foreground = :blue, bold = true), "> ",
             Crayon(foreground = :white, bold = false), query)
    if wait_for_key
        println( Crayon(foreground = :blue, italics = true), "...Press Enter to continue...")
        userinput = readline()
        exit_attempt(userinput) && exit()
    end
end

"""
    request_read_evaluate(request, var, answer)

The three parameter request_read_evaluate() function compares the user input as parsed julia code
to a determine if they successfully instantiated a variable (var::Symbol) to be the correct value(answer).

Note if a lesson goes like the following:
code: request_read_evaluate(    "make a str console_output to be \"Hello World\"",
                                :console_output,
                                "Hello World")

Correct UI: console_output = "Hello World"
Correct UI: console_output="Hello World"
Incorrect UI: cons_out = "Hello World"
Incorrect UI: console_output = "Hello Wurld"

"""
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

"""
    request_read_evaluate(request, answer)

The two parameter request_read_evaluate() function compares the console output to
a users input after a "request" prompt directly with a ground truth output.

Note if a lesson goes like the following:
code: request_read_evaluate(    "make a str console_output to be \"Hello World\"",
                                :console_output,
                                "Hello World")
UI: console_output = "Hello World"
code: request_read_evaluate(    "print console_output to the REPL",
                                "Hello World")
UI: print(console_output)

A correct UI could also be: print("Hello" * " " * "World")
because it displays the same as the intended answer.
"""
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
