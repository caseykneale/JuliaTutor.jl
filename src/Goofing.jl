function spongespek(phrase::String)
    casecounter = 0
    spek = ""
    for letter in phrase
        casecounter += 1
        if casecounter % 2 == 1
            spek *= uppercase(letter)
        else
            spek *= lowercase(letter)
        end
    end
    println(spek)
end

initrepl(
    spongespek, 
    prompt_text="julia tutor> ",
    prompt_color = :yellow, 
    start_key=')', 
    mode_name="tutor_mode",
    valid_input_checker=complete_julia
)
