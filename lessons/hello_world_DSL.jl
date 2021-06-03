# This file contains an Example Lesson plan for Julia tutor.

prompt_1 = "" *
"Welcome to your first day of class. Today we'll be doing a classic excercise. We will be learning " *
"how to print text to our console. Along the way we'll cover some ways to handle strings in Julia." *
"\n" *
"Strings are defined by double quotes \" \" in julia. For example, we could define a variable, " *
"called console_output to contain the text \"hello world\" like the following,\n" *
"console_output = \"hello world\"\n" *
"\n" *
"Okay now it's your turn,\n"
request_1 = "Define a string titled \'console_output\' to contain the text \"hello world\""
evaluator_1 = ExpressionEvaluator(:console_output, "hello world")
hint_1 = """Please ensure your solution is cases sensitive.
IE: "HeLlO WoRlD" is not the same as "hello world". """

# These four items compose a single lesson instance.
lesson_1 = Lesson(prompt_1, request_1, evaluator_1, hint_1)

prompt_2 = "" *
"Congratulations you have instantiated your first variable in Julia! How might we display this" *
"text to console? There are two functions that let you do this: print() and println(). Print " *
"will display the String or variable as it is, but println will add a new line/carriage return"
" to the end of it.\n" *
"\n" *
"Now that our console_output variable is stored in memory, we can print it as follows:\n" *
"print(console_output)\n"
request_2 = "Print your \'console_output\' variable to the console using the `print()` function"
evaluator_2 = CommandEvaluator("hello world")
# Notice: we did not provide any hints for this excercise. Not nice, but either they get it,
# or they don't. 
lesson_2 = Lesson(prompt_2, request_2, evaluator_2)

# To create the lesson_plan (which is REQUIRED) we make an array of Lesson's.
lesson_plan = [ lesson_1, lesson_2 ]