if Cryptid then
    local aliases = {
        -- Jokers
        ["up to eleven"] = "j_mstg_up_to_eleven",
        ["shredder"] = "j_mstg_paper_shredder",
        ["the better sacrifice"] = "j_mstg_sacrifice",
        ["evil sacrifice"] = "j_mstg_sacrifice",
        ["break glass"] = "j_mstg_emergency",
    }

    for k, v in pairs(aliases) do
        Cryptid.aliases[k] = v
    end
end
