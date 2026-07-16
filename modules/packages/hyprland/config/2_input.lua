function Input(input)
    Config({
        input = {
            kb_layout = JoinStrings(input.layouts or { "us" }, ", "),
            sensitivity = input.sensivity or 1.0
        }
    })
end
