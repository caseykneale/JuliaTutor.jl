module JuliaTutor
    using Crayons, Logging, ReplMaker, DataStructures, TerminalMenus

    #Handle lesson plans
    global LESSON_PATH = Base.joinpath( @__DIR__ ,  "Lessons" )
    lessons_available = readdir( LESSON_PATH )
    
    #Parsing functions for the menu system
    #TODO: Make the menu system part of the replmake parser?...
    #or use some nice CLI package
    strip_whitespace(ui) = filter(x -> !isspace(x), ui)

    function exit_attempt(ui)
        ui = strip_whitespace(ui)
        str_length = min(4, length(ui)) 
        return lowercase(ui[1:str_length]) == "exit"
    end

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
    global julia_tutor_parser = Tutor("",0,[])

    function load_lesson(lesson_location::String)
        include( lesson_location )


        if !@isdefined(lesson_plan) || (length(lesson_plan) == 0)
            println("The lesson you have attempted to load is lacking a valid `lesson_plan` variable.")
            return nothing
        end

        global julia_tutor_parser = Tutor( lesson_location, 0, lesson_plan )
        
        parser_closure(str) = julia_tutor_parser(str) 

        initrepl(
            parser_closure,#julia_tutor_parser, 
            prompt_text="julia tutor> ",
            prompt_color = :yellow, 
            start_key=')', 
            mode_name="tutor_mode",
            valid_input_checker=complete_julia
        )
    end
    export load_lesson

    #Construct main menu.
    """
        menu()

    Greets an end user, but then prompts them to select a lesson plan from /Lessons/
    Once a lesson is selected(by entering a numerical value) it will load that lesson and begin.
    """
    function menu()
        greet()
        menu_statement = """Please enter the numeral for lesson plan you want to do.
        Note: you can type \"exit\" and press enter at any time to exit this Julia session and JuliaTutor."""
        println( red_bold(), "> ", white_bold(), menu_statement )
        menut = RadioMenu( lessons_available, pagesize = 7)
        choice = TerminalMenus.request("", menut)

        load_lesson( Base.joinpath( LESSON_PATH, lessons_available[choice] ) )
    end
    export menu

end # module