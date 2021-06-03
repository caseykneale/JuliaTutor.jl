"""
    user_experience(syntax_error, incorrect_answer)::Bool

Convenience function to handle the feedback a user see's when they enter invalid, incorrect, or correct code.
Returns a bool as to whether their input was correct (true) or not (false).
"""
function user_experience(syntax_error, incorrect_answer)
    if syntax_error
        println(Crayon(foreground=:white, italics=true), "🔧 Sorry it appears there is a syntax error in your code. Please try again!")
    elseif incorrect_answer
        println(Crayon(foreground=:white, italics=true), "⅁ Good try but, this isn't the answer we are looking for. Please try again.")
    end
    correct = !syntax_error && !incorrect_answer
    if correct
        println(Crayon(foreground=:blue, italics=true), "✔ Good job!")
    end
    print(Crayon(foreground=:white, italics=false))
    return correct
end

abstract type Evaluator; end

struct ExpressionEvaluator <: Evaluator
    variable
    answer
end

# """
#     (ee::ExpressionEvaluator)(userinput::String)::Bool

# Functor for evaluating expression input's. Thinly wraps `evaluate(,,)`
# """
function (ee::ExpressionEvaluator)(userinput::String)::Bool
    (syntax_error, incorrect_answer) = evaluate(userinput, ee.variable, ee.answer)
    return user_experience(syntax_error, incorrect_answer)
end

struct CommandEvaluator <: Evaluator
    answer
end

# """
#     (ce::CommandEvaluator)(userinput::String)::Bool

# Functor for evaluating command input's. Thinly wraps `evaluate(,)`.
# """
function (ce::CommandEvaluator)(userinput::String)::Bool
    (syntax_error, incorrect_answer) = evaluate(userinput, ce.answer)
    return user_experience(syntax_error, incorrect_answer)
end