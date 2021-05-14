function user_experience(syntax_error, incorrect_answer)
    if syntax_error
        println(Crayon( foreground = :white, italics = true ), "🔧 Sorry it appears there is a syntax error in your code. Please try again!")
    elseif incorrect_answer
        println(Crayon( foreground = :white, italics = true ), "⅁ Good try but, this isn't the answer we are looking for. Please try again.")
    end
    correct = !syntax_error && !incorrect_answer
    if correct
        println(Crayon( foreground = :blue, italics = true ), "✔ Good job!" )
    end
    return correct
end

abstract type Evaluator; end

struct ExpressionEvaluator <: Evaluator
    variable
    answer
end

function (ee::ExpressionEvaluator)(userinput::String)
    (syntax_error, incorrect_answer) = evaluate(userinput, ee.variable, ee.answer)
    return user_experience(syntax_error, incorrect_answer)
end

struct CommandEvaluator <: Evaluator
    answer
end

function (ce::CommandEvaluator)(userinput::String)
    (syntax_error, incorrect_answer) = evaluate(userinput, ce.answer)
    return user_experience(syntax_error, incorrect_answer)
end