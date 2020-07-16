module JuliaTutor
    using Crayons, Logging
    greet() = print("Hi my name is JuliaTutor, \n
                    Here you can learn interactively through pre-made lessons.")

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

    #https://github.com/travigd/ComparativeAutograder.jl/blob/f9e99eaec800ecb8ca5f919e820b967dd27fe063/src/stdio.jl#L3
    #Travis DePrato
    """
        @capture_stdstreams(expr)
    Evaluate the specified expression and return a `(stdout, stderr)` tuple.
    This macro will attempt to capture every form of output, including via the
    `Logging` module (_e.g._ the `@logmsg` and friend macros), but it's unable to
    do this with perfect accuracy. Any code that stores a reference to `stdout` or
    `stderr` before this is executed will retain those references to the original
    streams.
    For example, the original log instance may be obtained using
    `Logging.global_logger()` because no attempt is made to set the global logger
    instance.
    # Examples
    ```julia-repl
    julia> out, err = ComparativeAutograder.@capture_stdstreams begin
               println("I'm going to out!")
               println(stderr, "I'm going to err!")
           end
    ("I'm going to out!\\n", "I'm going to err!\\n")
    ```
    """
    macro capture_stdstreams(expr)
        # We use a whole bunch of `gensym`'s to avoid polluting the namespace
        out, outread, outwrite, outtask = gensym.([:stdout, :outread, :outwrite, :outtask])
        err, errread, errwrite, errtask = gensym.([:stderr, :errread, :errwrite, :errtask])
        return quote
            $out, $err = Base.stdout, Base.stderr
            $outread, $outwrite = redirect_stdout()
            $errread, $errwrite = redirect_stderr()
            $outtask = @async read($outread, String)
            $errtask = @async read($errread, String)
            try
                with_logger(ConsoleLogger(Base.stderr, Logging.Debug)) do
                    $(esc(expr))
                end
            catch (e)
                rethrow(e)
            finally
                redirect_stdout($out)
                redirect_stderr($err)
                close.([$outwrite, $errwrite])
            end
            fetch($outtask), fetch($errtask)
        end
    end

    exit_attempt(ui) = lowercase(ui[1:min(4,length(ui))]) == "exit"
    strip_whitespace(ui) = filter(x -> !isspace(x), ui)

    function inform(query)
        println( Crayon(foreground = :blue, bold = true), "> ",
                 Crayon(foreground = :white, bold = false), query)
        println( Crayon(foreground = :blue, italics = true), "...Press any key to continue...")
        userinput = readline()
        exit_attempt(userinput) && exit()
    end

    function evaluate(ui, var, ans)::Tuple{ Bool, Bool }
        #try to run the users code
        syntax_error, incorrect_answer = false, false;
        ui_ex = Meta.parse( ui )
        try; eval( ui_ex ); catch; syntax_error = true; end
        # check whether the variable is defined
        try; eval( var ); catch; incorrect_answer = true; end
        # if defined check whether it is set to the correct answer
        !incorrect_answer && (incorrect_answer = !(eval(var) === ans))
        return (syntax_error, incorrect_answer)
    end

    function evaluate(ui, truth)::Tuple{ Bool, Bool }
        syntax_error, incorrect_answer = false, false;
        ui_ex = Meta.parse( ui )
        result = nothing
        try; result = @capture_stdstreams( Main.eval( ui_ex ) ); catch; syntax_error = true; end
        # Check whether it is set to the correct answer
        if !isnothing( result)
            incorrect_answer = !( first( result ) == truth )
        else
            incorrect_answer = false
        end
        return ( syntax_error, incorrect_answer )
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
    export inform, request_read_evaluate, evaluate

end # module
