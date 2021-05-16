struct Lesson
    prompt::String
    request::String
    parser::Evaluator
    hint::String
end

"""
    Lesson(prompt::String, request::String, parser::Evaluator)

Will create a Lesson instance without a hint. 
Note: it is strongly preferred that Lesson's contain `hints` so please construct via 
Lesson( prompt::String, request::String, parser::Evaluator, hint::String ) except when neccesary.
"""
Lesson(prompt::String, request::String, parser::Evaluator) = Lesson(prompt, request, parser, "")

mutable struct Tutor
    lesson_path::String
    current_lesson::Int16
    lesson_plan::Vector{Lesson}
end

"""
    display_prompt_and_request(t::Tutor)

Displays a lesson prompt and requests an action from the user.
"""
function display_prompt_and_request(t::Tutor)
    active_lesson = t.lesson_plan[t.current_lesson]
    inform(active_lesson)
    request(active_lesson)
end

"""
    display_hint(t::Tutor)

Displays a hint pertaining to the users current lesson, if it exists. See `hint(lesson::Lesson)`
"""
function display_hint(t::Tutor)
    active_lesson = t.lesson_plan[t.current_lesson]
    hint(active_lesson)
end

"""
    keywords(t, user_input)

Assesses if the user has asked for help, hint, or some other invention specific to JuliaTutor.
"""
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

"""
    ( t::Tutor )( user_input::String )

This is the parser, and lesson plan orchestration mechanism of Julia tutor. This functor progresses the user 
through lessons and parsers their inputs.
"""
function ( t::Tutor )( user_input::String )
    active_lesson = t.lesson_plan[ t.current_lesson ]
    if active_lesson.parser( user_input )
        if t.current_lesson < length(t.lesson_plan) 
            t.current_lesson += 1
            display_prompt_and_request( t )
        else
            println( Crayon(foreground = :green, bold = true),
                    "\n Congratulations! " * 
                    "\n You've completed this lesson. Care to try another? \n")
            print(Crayon( foreground = :white, bold = false), "" )
            menu()
        end
    end
end
