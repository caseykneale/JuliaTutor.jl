prompt_1 = """
Part I
or some really long prompt explaining the background of what you want the user to learn.
"""
request_1 = "Define a string titled \'console_output\' to contain the text \"Hello World\""
evaluator_1 = ExpressionEvaluator(:console_output, "Hello World")
lesson_1 = Lesson( prompt_1, request_1, evaluator_1 )

prompt_2 = """
Part II
or some really long prompt explaining the background of what you want the user to learn.
"""
request_2 = "Print your \'console_output\' variable to the console using the `print()` function"
evaluator_2 = CommandEvaluator("Hello World")
lesson_2 = Lesson( prompt_2, request_2, evaluator_2 )

lesson_plan = [ lesson_1, lesson_2 ]
