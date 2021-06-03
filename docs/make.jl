using JuliaTutor
using Documenter

@info "Makeing documentation..."
makedocs(;
    modules=[JuliaTutor],
    authors="caseykneale",
    repo="https://github.com/Humans-of-Julia/JuliaTutor.jl/blob/{commit}{path}#L{line}",
    sitename="JuliaTutor.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", nothing) == "true",
        canonical="https://Humans-of-Julia.github.io/JuliaTutor.jl",
        assets=["assets/favicon.ico"; "assets/github_buttons.js"; "assets/custom.css"],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/Humans-of-Julia/JuliaTutor.jl",
    devbranch="master",
)
