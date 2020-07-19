# JuliaTutor

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://caseykneale.github.io/JuliaTutor.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://caseykneale.github.io/JuliaTutor.jl/dev)
[![Build Status](https://github.com/caseykneale/JuliaTutor.jl/workflows/CI/badge.svg)](https://github.com/caseykneale/JuliaTutor.jl/actions)
[![Coverage](https://codecov.io/gh/caseykneale/JuliaTutor.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/caseykneale/JuliaTutor.jl)

## How to test drive
 - Clone the pkg
 - Activate it
 - Pkg.dev / Pkg.add it locally (CD to directory?)
 - and run the menu function

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
 - Although advanced lessons could be placed in here, it's pretty out of scope. Topics like:
   - Hello World (+ pipes + basic string concatenation).
   - Loading packages(import vs using, etc)?
   - Defining vectors/matrices (+ broadcast operations)
   - The world is your oyster...

## Current "Design" (high-level)
  - JuliaTutor.jl reads lessons in `/Lessons/` and displays a menu which allows users to interactively learn from.
  - Lessons contain(see `HelloWorld.jl` for an example):
    - dialogs via `inform()`
    - `request_read_evaluate()` functions.
      - these can handle cases where new variables are instantiated
      - or a REPL output of a users entry is captured and compared to a ground truth
      - These functions tell a user at least if they made a syntax error, or if they gave the wrong answer.
  - That's basically it?
  - Oh CrayonBox.jl has some code generated functions to make printed text more concise.
