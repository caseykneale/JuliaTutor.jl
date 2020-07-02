using JuliaTutor
using Documenter

makedocs(;
    modules=[JuliaTutor],
    authors="caseykneale",
    repo="https://github.com/caseykneale/JuliaTutor.jl/blob/{commit}{path}#L{line}",
    sitename="JuliaTutor.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://caseykneale.github.io/JuliaTutor.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/caseykneale/JuliaTutor.jl",
)
