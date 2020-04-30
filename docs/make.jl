using FileRules
using Documenter

makedocs(;
    modules=[FileRules],
    authors="Qi Zhang <singularitti@outlook.com>",
    repo="https://github.com/singularitti/FileRules.jl/blob/{commit}{path}#L{line}",
    sitename="FileRules.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://singularitti.github.io/FileRules.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/singularitti/FileRules.jl",
)
