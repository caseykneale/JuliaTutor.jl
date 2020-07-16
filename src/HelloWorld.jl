using Pkg
Pkg.activate("JuliaTutor")
using JuliaTutor

JuliaTutor.greet()

"""Welcome to your first day of class. Today we'll be doing a classic
excercise. We will be learning how to print text to our console. Along
the way we'll cover some ways to handle strings in Julia.

Strings are defined by double quotes \" \" in julia. For example, we
could define a variable, called console_output to contain the text
\"Hello World\" like the following,

console_output = \"Hello World\"

Okay now it's your turn,""" |> inform

request_read_evaluate( "Define a string titled \'console_output\' to contain the text \"Hello World\"",
                    "console_output = \"Hello World\"")
#console_output = "Hello World"
