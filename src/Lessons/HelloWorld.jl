# """
# Welcome to your first day of class. Today we'll be doing a classic
# excercise. We will be learning how to print text to our console. Along
# the way we'll cover some ways to handle strings in Julia.

# Strings are defined by double quotes \" \" in julia. For example, we
# could define a variable, called console_output to contain the text
# \"Hello World\" like the following,

# console_output = \"Hello World\"

# Okay now it's your turn,
# """ |> inform

# request_read_evaluate( "Define a string titled \'console_output\' to contain the text \"Hello World\"",
#                     :console_output, "Hello World")

# """
# Awesome! So, in a REPL(Read-Evaluate-Print-Loop) you may see the the output of this string
# returned to you after defining a variable. To suppress this, you can add a semilcolon to the end of
# any line of Julia code. This tells the Julia parser to reach the following code as a new instruction,
# or, to suppress outputs (kind of like Matlab).
# console_output = \"Hello World\";

# But, now we must learn how to print to console. There are two functions that let you do this:
# print() and println(). Print will display the String or variable as it is, but println will add
# new line/carriage return to the end of it.

# Now that our console_output variable is stored in memory, we can print it as follows:

# print(console_output)
# """ |> inform

# console_output = "Hello World"

# request_read_evaluate(  "Print your \'console_output\' variable to the console",
#                         "Hello World" )
