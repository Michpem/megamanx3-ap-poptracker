
function has(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    amount = tonumber(amount)
    if not amount then
        return count > 0
    else
        return count >= amount
    end
end

function can_charge()
    local arms = Tracker:FindObjectForCode("arms").CurrentStage
    return arms >= 2
end

function boss_weaknesses_not_required()
    local logic_boss_unshuffled_weakness = Tracker:FindObjectForCode('logic_boss_unshuffled_weakness').CurrentStage == 1
    return not logic_boss_unshuffled_weakness
end

function get_weapons_count()
    local weapons = 0
    if Tracker:FindObjectForCode("frost_shield").Active then weapons = weapons + 1 end
    if Tracker:FindObjectForCode("acid_burst").Active then weapons = weapons + 1 end
    if Tracker:FindObjectForCode("tornado_fang").Active then weapons = weapons + 1 end
    if Tracker:FindObjectForCode("triad_thunder").Active then weapons = weapons + 1 end
    if Tracker:FindObjectForCode("spinning_blade").Active then weapons = weapons + 1 end
    if Tracker:FindObjectForCode("ray_splasher").Active then weapons = weapons + 1 end
    if Tracker:FindObjectForCode("gravity_well").Active then weapons = weapons + 1 end
    if Tracker:FindObjectForCode("parasitic_bomb").Active then weapons = weapons + 1 end
    return weapons
end
function get_upgrades_count()
    local upgrades = 0
    upgrades = upgrades + Tracker:FindObjectForCode("third_armor_helmet").CurrentStage
    upgrades = upgrades + Tracker:FindObjectForCode("third_armor_body").CurrentStage
    upgrades = upgrades + Tracker:FindObjectForCode("third_armor_legs").CurrentStage
    local arms = Tracker:FindObjectForCode("third_armor_arms").CurrentStage
    if Tracker:FindObjectForCode('jammed_buster').CurrentStage == 0 then
        if arms > 1 then upgrades = upgrades + arms - 1 end
    else
        upgrades = upgrades + arms
    end
    return upgrades
end

function vile_codes_req_met()
    return Tracker:FindObjectForCode("stage_vile").Active
end
function vile_medals_req_met()
    local mavericks = Tracker:ProviderCountForCode("maverick_medal")
    local mavericks_needed = Tracker:ProviderCountForCode("vile_medal_count")
    return mavericks >= mavericks_needed
end
function vile_weapons_req_met()
    local weapons = get_weapons_count()
    local weapons_needed = Tracker:ProviderCountForCode("vile_weapon_count")
    return weapons >= weapons_needed
end
function vile_upgrade_req_met()
    local upgrades = get_upgrades_count()
    local upgrades_needed = Tracker:ProviderCountForCode("vile_upgrade_count")
    return upgrades >= upgrades_needed
end
function vile_heart_tanks_req_met()
    local heart_tanks = Tracker:ProviderCountForCode("heart_tank")
    local heart_tanks_needed = Tracker:ProviderCountForCode("vile_heart_tank_count")
    return heart_tanks >= heart_tanks_needed
end
function vile_sub_tanks_req_met()
    local sub_tanks = Tracker:ProviderCountForCode("sub_tank")
    local sub_tanks_needed = Tracker:ProviderCountForCode("vile_sub_tank_count")
    return sub_tanks >= sub_tanks_needed
end
function vile_all_req_met()
    return vile_medals_req_met() and vile_weapons_req_met() and vile_upgrade_req_met() and vile_heart_tanks_req_met() and vile_sub_tanks_req_met()
end

function is_vile_open()
    local allreqs = Tracker:ProviderCountForCode("vile_sub_tank_count") + Tracker:ProviderCountForCode("vile_heart_tank_count") + Tracker:ProviderCountForCode("vile_upgrade_count") + Tracker:ProviderCountForCode("vile_weapon_count") + Tracker:ProviderCountForCode("vile_medal_count")
    if allreqs == 0 then
        return vile_codes_req_met()
    end
    return vile_all_req_met()
end

function update_vile_state()
    local vilestate = Tracker:FindObjectForCode('vile_state')
    if Tracker:FindObjectForCode('vile_cleared').Active then
        vilestate.CurrentStage = 2
    elseif is_vile_open() then
        vilestate.CurrentStage = 1
    else
        vilestate.CurrentStage = 0
    end
end


function doppler_codes_req_met()
    return Tracker:FindObjectForCode("stage_doppler_lab").Active
end
function doppler_medals_req_met()
    local mavericks = Tracker:ProviderCountForCode("maverick_medal")
    local mavericks_needed = Tracker:ProviderCountForCode("doppler_medal_count")
    return mavericks >= mavericks_needed
end
function doppler_weapons_req_met()
    local weapons = get_weapons_count()
    local weapons_needed = Tracker:ProviderCountForCode("doppler_weapon_count")
    return weapons >= weapons_needed
end
function doppler_upgrade_req_met()
    local upgrades = get_upgrades_count()
    local upgrades_needed = Tracker:ProviderCountForCode("doppler_upgrade_count")
    return upgrades >= upgrades_needed
end
function doppler_heart_tanks_req_met()
    local heart_tanks = Tracker:ProviderCountForCode("heart_tank")
    local heart_tanks_needed = Tracker:ProviderCountForCode("doppler_heart_tank_count")
    return heart_tanks >= heart_tanks_needed
end
function doppler_sub_tanks_req_met()
    local sub_tanks = Tracker:ProviderCountForCode("sub_tank")
    local sub_tanks_needed = Tracker:ProviderCountForCode("doppler_sub_tank_count")
    return sub_tanks >= sub_tanks_needed
end
function doppler_all_req_met()
    return doppler_medals_req_met() and doppler_weapons_req_met() and doppler_upgrade_req_met() and doppler_heart_tanks_req_met() and doppler_sub_tanks_req_met()
end

function is_doppler_open()
    local allreqs = Tracker:ProviderCountForCode("doppler_sub_tank_count") + Tracker:ProviderCountForCode("doppler_heart_tank_count") + Tracker:ProviderCountForCode("doppler_upgrade_count") + Tracker:ProviderCountForCode("doppler_weapon_count") + Tracker:ProviderCountForCode("doppler_medal_count")

    local vilereq = Tracker:FindObjectForCode("logic_vile_required").CurrentStage
    local vilebeat = Tracker:FindObjectForCode("vile_cleared").Active
    local vile_cleared_met = true
    if vilereq > 0 then
        vile_cleared_met = vilebeat
    end
    if allreqs == 0 then
        return doppler_codes_req_met() and vile_cleared_met
    end
    return doppler_all_req_met() and vile_cleared_met

end
function update_doppler_state()
    local dopplerstate = Tracker:FindObjectForCode('drdoppler_state')
    if Tracker:FindObjectForCode('doppler_1_cleared').Active and Tracker:FindObjectForCode('doppler_2_cleared').Active and Tracker:FindObjectForCode('doppler_3_cleared').Active then
        dopplerstate.CurrentStage = 2
    elseif is_doppler_open() then
        dopplerstate.CurrentStage = 1
    else
        dopplerstate.CurrentStage = 0
    end
end
function are_doppler_two_and_three_open()
    if Tracker:FindObjectForCode('doppler_all_labs').CurrentStage > 0 then
        return Tracker:FindObjectForCode('drdoppler_state').CurrentStage > 0
    end
    return false
end

function doppler_1_cleared()
    if Tracker:FindObjectForCode("@Stages/Dr. Doppler's Lab 1/Dr. Doppler's Lab 1 Boss").AvailableChestCount == 0 then
        return true
    end
    return false
end
function doppler_2_cleared()
    if Tracker:FindObjectForCode("@Stages/Dr. Doppler's Lab 2/Dr. Doppler's Lab 2 Boss").AvailableChestCount == 0 then
        return true
    end
    return false
end

function is_bit_open()
    local mavericks = Tracker:ProviderCountForCode("maverick_medal")
    local mavericks_needed = Tracker:ProviderCountForCode("bit_medal_count")
    return mavericks >= mavericks_needed
end
function is_byte_open()
    local mavericks = Tracker:ProviderCountForCode("maverick_medal")
    local mavericks_needed = Tracker:ProviderCountForCode("byte_medal_count")
    return mavericks >= mavericks_needed
end
function rematch_quota_met()
    local quota = Tracker:ProviderCountForCode("doppler_lab_3_boss_rematch_count")
    --local count = Tracker:ProviderCountForCode("rematch_fights")
    local count = 0
    --print(string.format("refight quota: %i, refights done: %i", quota, count))
    if Tracker:FindObjectForCode("@Stages/Dr. Doppler's Lab 3/Blizzard Buffalo (Rematch)").AvailableChestCount == 0 then
        count = count + 1
    end
    if Tracker:FindObjectForCode("@Stages/Dr. Doppler's Lab 3/Toxic Seahorse (Rematch)").AvailableChestCount == 0 then
        count = count + 1
    end
    if Tracker:FindObjectForCode("@Stages/Dr. Doppler's Lab 3/Tunnel Rhino (Rematch)").AvailableChestCount == 0 then
        count = count + 1
    end
    if Tracker:FindObjectForCode("@Stages/Dr. Doppler's Lab 3/Volt Catfish (Rematch)").AvailableChestCount == 0 then
        count = count + 1
    end
    if Tracker:FindObjectForCode("@Stages/Dr. Doppler's Lab 3/Crush Crawfish (Rematch)").AvailableChestCount == 0 then
        count = count + 1
    end
    if Tracker:FindObjectForCode("@Stages/Dr. Doppler's Lab 3/Neon Tiger (Rematch)").AvailableChestCount == 0 then
        count = count + 1
    end
    if Tracker:FindObjectForCode("@Stages/Dr. Doppler's Lab 3/Gravity Beetle (Rematch)").AvailableChestCount == 0 then
        count = count + 1
    end
    if Tracker:FindObjectForCode("@Stages/Dr. Doppler's Lab 3/Blast Hornet (Rematch)").AvailableChestCount == 0 then
        count = count + 1
    end
    --print("found refights done: ", count)
    if count >= quota then
        return true
    else
        return false
    end

end

function print_debug_doppler()
    print("get_weapons_count(): ", get_weapons_count())
    print("get_upgrades_count(): ", get_upgrades_count())
    print("doppler_codes_req_met(): ", doppler_codes_req_met())
    print("doppler_medals_req_met(): ", doppler_medals_req_met())
    print("doppler_weapons_req_met(): ", doppler_weapons_req_met())
    print("doppler_upgrade_req_met(): ", doppler_upgrade_req_met())
    print("doppler_heart_tanks_req_met(): ", doppler_heart_tanks_req_met())
    print("doppler_sub_tanks_req_met(): ", doppler_sub_tanks_req_met())
    print("doppler_all_req_met(): ", doppler_all_req_met())
    print("is_doppler_open(): ", is_doppler_open())
    print("doppler_open object: ", Tracker:ProviderCountForCode("doppler_open"))
end

function print_debug_vile()
    print("get_weapons_count(): ", get_weapons_count())
    print("get_upgrades_count(): ", get_upgrades_count())
    print("vile_codes_req_met(): ", vile_codes_req_met())
    print("vile_medals_req_met(): ", vile_medals_req_met())
    print("vile_weapons_req_met(): ", vile_weapons_req_met())
    print("vile_upgrade_req_met(): ", vile_upgrade_req_met())
    print("vile_heart_tanks_req_met(): ", vile_heart_tanks_req_met())
    print("vile_sub_tanks_req_met(): ", vile_sub_tanks_req_met())
    print("vile_all_req_met(): ", vile_all_req_met())
    print("is_vile_open(): ", is_vile_open())
    print("vile_open object: ", Tracker:ProviderCountForCode("vile_open"))
end