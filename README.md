# JuliaTutor

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://caseykneale.github.io/JuliaTutor.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://caseykneale.github.io/JuliaTutor.jl/dev)
[![Build Status](https://github.com/caseykneale/JuliaTutor.jl/workflows/CI/badge.svg)](https://github.com/caseykneale/JuliaTutor.jl/actions)
[![Coverage](https://codecov.io/gh/caseykneale/JuliaTutor.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/caseykneale/JuliaTutor.jl)

## How to test drive
```
using Pkg
Pkg.activate("JuliaTutor")
using JuliaTutor

menu()
```

## Goals
 - Create a package an end user can Pkg.add("JuliaTutor")
 - The package will display a menu of "lesson plans" when the user executes `menu()`
 - Those lesson plans will hold a new users hand as they learn the language.
 - Although advanced lessons could be placed in here, it's pretty out of scope.
 - Novice level topics like:
   - Hello World (+ pipes + basic string concatenation).
   - Defining vectors/matrices (+ broadcast operations)
   - The world is your oyster...

## Current "Design" (high-level)
  - JuliaTutor.jl reads lessons in `/Lessons/` and displays a menu which allows users to interactively learn from.
  - Lessons contain(see `HelloWorld.jl` for an example)