struct Lesson
    prompt::String
    request::String
    parser::Evaluator
end

struct Tutor
    lesson_path::String
    current_lesson::Int16
    lesson_plan::Vector{Lesson}
end

function display_prompt_and_request(t::Tutor)
    active_lesson = t.lesson_path[t.current_lesson]
    inform(active_lesson)
    request(active_lesson)
end

function ( t::Tutor )( user_input::String ) 
    #TODO: Add cmd's for redisplaying prompt, clearing repl screen, hints?
    active_lesson = t.lesson_plan[ t.current_lesson ]
    if active_lesson.parser( user_input )
        t.current_lesson += 1
        display_prompt_and_request( t )
    else 
        #do nothing?
    end
end