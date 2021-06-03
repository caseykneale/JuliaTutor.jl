var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = JuliaTutor","category":"page"},{"location":"#JuliaTutor","page":"Home","title":"JuliaTutor","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [JuliaTutor]","category":"page"},{"location":"#JuliaTutor.Lesson-Tuple{String, String, JuliaTutor.Evaluator}","page":"Home","title":"JuliaTutor.Lesson","text":"Lesson(prompt::String, request::String, parser::Evaluator)\n\nWill create a Lesson instance without a hint.  Note: it is strongly preferred that Lesson's contain hints so please construct via  Lesson( prompt::String, request::String, parser::Evaluator, hint::String ) except when neccesary.\n\n\n\n\n\n","category":"method"},{"location":"#JuliaTutor.Tutor-Tuple{String}","page":"Home","title":"JuliaTutor.Tutor","text":"( t::Tutor )( user_input::String )\n\nThis is the parser, and lesson plan orchestration mechanism of Julia tutor. This functor progresses the user  through lessons and parsers their inputs.\n\n\n\n\n\n","category":"method"},{"location":"#JuliaTutor.display_hint-Tuple{JuliaTutor.Tutor}","page":"Home","title":"JuliaTutor.display_hint","text":"display_hint(t::Tutor)\n\nDisplays a hint pertaining to the users current lesson, if it exists. See hint(lesson::Lesson)\n\n\n\n\n\n","category":"method"},{"location":"#JuliaTutor.display_prompt_and_request-Tuple{JuliaTutor.Tutor}","page":"Home","title":"JuliaTutor.display_prompt_and_request","text":"display_prompt_and_request(t::Tutor)\n\nDisplays a lesson prompt and requests an action from the user.\n\n\n\n\n\n","category":"method"},{"location":"#JuliaTutor.evaluate-Tuple{Any, Any, Any}","page":"Home","title":"JuliaTutor.evaluate","text":"evaluate(ui, truth)::Tuple{ Bool, Bool }\n\nEvaluates the output of a user's input against ground truth, and the variable declaration.\n\n\n\n\n\n","category":"method"},{"location":"#JuliaTutor.evaluate-Tuple{Any, Any}","page":"Home","title":"JuliaTutor.evaluate","text":"evaluate(ui, truth)::Tuple{ Bool, Bool }\n\nEvaluates the output of a user's input against ground truth.\n\n\n\n\n\n","category":"method"},{"location":"#JuliaTutor.greet-Tuple{}","page":"Home","title":"JuliaTutor.greet","text":"greet()\n\nGreets the user the first time they run JuliaTutor.\n\n\n\n\n\n","category":"method"},{"location":"#JuliaTutor.help-Tuple{}","page":"Home","title":"JuliaTutor.help","text":"help()\n\nDisplays generic tips for how to navigate JuliaTutor.\n\n\n\n\n\n","category":"method"},{"location":"#JuliaTutor.hint-Tuple{JuliaTutor.Lesson}","page":"Home","title":"JuliaTutor.hint","text":"hint(lesson::Lesson)\n\nDisplays a hint for the user, if the lesson provides it. Otherwise - it directs the user to Discourse.\n\n\n\n\n\n","category":"method"},{"location":"#JuliaTutor.inform-Tuple{JuliaTutor.Lesson}","page":"Home","title":"JuliaTutor.inform","text":"inform(lesson::Lesson)\n\nA convenience function to display the prompt of a lesson to an end user.\n\n\n\n\n\n","category":"method"},{"location":"#JuliaTutor.keywords-Tuple{Any, Any}","page":"Home","title":"JuliaTutor.keywords","text":"keywords(t, user_input)\n\nAssesses if the user has asked for help, hint, or some other invention specific to JuliaTutor.\n\n\n\n\n\n","category":"method"},{"location":"#JuliaTutor.load_lesson-Tuple{String}","page":"Home","title":"JuliaTutor.load_lesson","text":"load_lesson(lesson_location::String)\n\nreads a structured Lesson file and begins a Julia tutor REPL, parser, etc.\n\n\n\n\n\n","category":"method"},{"location":"#JuliaTutor.menu-Tuple{}","page":"Home","title":"JuliaTutor.menu","text":"menu()\n\nGreets an end user, but then prompts them to select a lesson plan from /Lessons/ Once a lesson is selected(by entering a numerical value) it will load that lesson and begin.\n\n\n\n\n\n","category":"method"},{"location":"#JuliaTutor.request-Tuple{JuliaTutor.Lesson}","page":"Home","title":"JuliaTutor.request","text":"request(lesson::Lesson)\n\nA convenience function to display what action is requested for an end user to accomplish.\n\n\n\n\n\n","category":"method"},{"location":"#JuliaTutor.user_experience-Tuple{Any, Any}","page":"Home","title":"JuliaTutor.user_experience","text":"user_experience(syntax_error, incorrect_answer)::Bool\n\nConvenience function to handle the feedback a user see's when they enter invalid, incorrect, or correct code. Returns a bool as to whether their input was correct (true) or not (false).\n\n\n\n\n\n","category":"method"},{"location":"#JuliaTutor.@capture_stdstreams-Tuple{Any}","page":"Home","title":"JuliaTutor.@capture_stdstreams","text":"@capture_stdstreams(expr)\n\nEvaluate the specified expression and return a (stdout, stderr) tuple. This macro will attempt to capture every form of output, including via the Logging module (e.g. the @logmsg and friend macros), but it's unable to do this with perfect accuracy. Any code that stores a reference to stdout or stderr before this is executed will retain those references to the original streams. For example, the original log instance may be obtained using Logging.global_logger() because no attempt is made to set the global logger instance.\n\nExamples\n\njulia> out, err = ComparativeAutograder.@capture_stdstreams begin\n           println(\"I'm going to out!\")\n           println(stderr, \"I'm going to err!\")\n       end\n(\"I'm going to out!\\n\", \"I'm going to err!\\n\")\n\n\n\n\n\n","category":"macro"}]
}
