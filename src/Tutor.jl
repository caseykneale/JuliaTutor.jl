struct Lesson
    prompt::String
    request::String
    parser::Evaluator
    hint::String
end

Lesson(prompt::String, request::String, parser::Evaluator) = Lesson(prompt, request, parser, "")

mutable struct Tutor
    lesson_path::String
    current_lesson::Int16
    lesson_plan::Vector{Lesson}
end

function display_prompt_and_request(t::Tutor)
    active_lesson = t.lesson_plan[t.current_lesson]
    inform(active_lesson)
    request(active_lesson)
end

function display_hint(t::Tutor)
    active_lesson = t.lesson_plan[t.current_lesson]
    hint(active_lesson)
end

function keywords(t, user_input)
    used_keyword = false
    #ToDo:: strip whitespace, add more keywords?
    if (user_input == "help") || (user_input == "help()")
        help()
        used_keyword = true
    elseif (user_input == "hint") || (user_input == "hint()")
        display_hint( t )
        used_keyword = true
    end
    return used_keyword
end

function ( t::Tutor )( user_input::String )
    #TODO: Add cmd's for redisplaying prompt, clearing repl screen, hints?
    active_lesson = t.lesson_plan[ t.current_lesson ]
    if active_lesson.parser( user_input )
        if t.current_lesson < length(t.lesson_plan) 
            t.current_lesson += 1
            display_prompt_and_request( t )
        else
            println( Crayon(foreground = :green, bold = true),
                    "\n Congratulations! \n You've completed this lesson. Care to try another? \n")
            print(Crayon( foreground = :white, bold = false), "" )
            menu()
        end
    end
    #return Meta.eval( Meta.parse(user_input) )
end
