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

"""
    evaluate(ui, truth)::Tuple{ Bool, Bool }

Evaluates the output of a user's input against ground truth, and the variable declaration.
"""
function evaluate(ui, var, ans)::Tuple{ Bool, Bool }
    #try to run the users code
    syntax_error, incorrect_answer = false, false;
    ui_ex = Meta.parse( ui )
    try; Meta.eval( ui_ex ); catch; syntax_error = true; end
    # check whether the variable is defined
    try; Meta.eval( var ); catch; incorrect_answer = true; end
    # if defined check whether it is set to the correct answer
    !incorrect_answer && (incorrect_answer = !(Meta.eval(var) === ans))
    return (syntax_error, incorrect_answer)
end

"""
    evaluate(ui, truth)::Tuple{ Bool, Bool }

Evaluates the output of a user's input against ground truth.
"""
function evaluate(ui, truth)::Tuple{ Bool, Bool }
    syntax_error, incorrect_answer = false, false;
    ui_ex = Meta.parse( ui )
    result = nothing
    #maybe use Main.eval?
    try; result = @capture_stdstreams( Meta.eval( ui_ex ) ); catch; syntax_error = true; end
    # Check whether it is set to the correct answer
    if !isnothing( result)
        incorrect_answer = !( first( result ) == truth )
    else
        incorrect_answer = false
    end
    return ( syntax_error, incorrect_answer )
end
