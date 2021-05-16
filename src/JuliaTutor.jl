module JuliaTutor
    using Crayons, Logging, ReplMaker, DataStructures, TerminalMenus
    global repl = nothing
    #Handle lesson plans
    global LESSON_PATH = Base.joinpath( @__DIR__ ,  "Lessons" )
    lessons_available = readdir( LESSON_PATH )
    push!(lessons_available, "Exit Julia Tutor") #provide an easy way out
    
    #Internal to JuliaTutor
    include("CrayonBox.jl")
    include("CaptureAndEvaluate.jl")
    #External to JuliaTutor IE user facing    
    include("Evaluators.jl")
    #export user_experience, Evaluator, ExpressionEvaluator, CommandEvaluator
    include("Tutor.jl")
    #export Lesson, Tutor, display_prompt_and_request
    include("Display.jl")
    #export greet, inform, request
    export help

    global julia_tutor_parser = Tutor("",0,[])
    export julia_tutor_parser

    """
        load_lesson(lesson_location::String)

    reads a structured Lesson file and begins a Julia tutor REPL, parser, etc.
    """
    function load_lesson(lesson_location::String)
        include( lesson_location )

        if !@isdefined(lesson_plan) || (length(lesson_plan) == 0)
            println("The lesson you have attempted to load is lacking a valid `lesson_plan` variable.")
            return nothing
        end

        global julia_tutor_parser = Tutor( lesson_location, 1, lesson_plan )
        
        function parser_closure(user_input)
            if keywords(julia_tutor_parser, user_input)
                return
            end
            #Display the executed output of the users input
            io = IOBuffer()
            io_context = IOContext( io, :limit => true, :displaysize => (7, 70))
            show(io_context, "text/plain", Meta.eval(Meta.parse(user_input)) );
            println( String( take!( io ) ) )
            #Parse and evaluate the users input
            julia_tutor_parser(user_input)
        end
        #Instantiate a REPL
        global repl = initrepl(
            parser_closure, #ReplMaker doesn't allow functors
            prompt_text="julia tutor> ",
            prompt_color = :yellow, 
            start_key=')', 
            mode_name="tutor_mode",
            valid_input_checker=complete_julia
        )
        #Enter the REPL without user approval
        ReplMaker.enter_mode!(Base.active_repl.mistate, repl)
        #Display the first lesson prompt
        display_prompt_and_request(julia_tutor_parser)
    end
    export load_lesson

    #Construct main menu.
    """
        menu()

    Greets an end user, but then prompts them to select a lesson plan from /Lessons/
    Once a lesson is selected(by entering a numerical value) it will load that lesson and begin.
    """
    function menu()
        menu_statement = """Please enter the numeral for lesson plan you want to do.
        Note: you can type \"exit()\" and press enter at any time to exit this Julia session and JuliaTutor."""
        println( red_bold(), "> ", white_bold(), menu_statement )
        menut = RadioMenu( lessons_available, pagesize = 7)
        choice = lessons_available[ TerminalMenus.request( "", menut ) ]
        if choice == "Exit Julia Tutor"
            exit()
        else
            load_lesson( Base.joinpath( LESSON_PATH, choice ) )
        end
    end
    export menu
    
    greet()
end # module