using Pkg
Pkg.activate("JuliaTutor")
using JuliaTutor

JuliaTutor.greet()

"""this is some sort of prompt or something.
maybe some long instruction set!
maybe someone droning on and on about julia?""" |> inform

request_read_evaluate( "Define a variable `a` to be the integer 1234",
                    :a, 1234)

