ADDRESSES = {
    {"Abydos", {26, 6, 14, 31, 11, 29, 0}},
    {"Chulak", {8, 1, 22, 14, 36, 19, 0}},
    {"Cavum Tenebrae", {18, 7, 3, 36, 25, 15, 0}},
    {"Lantea", {18, 20, 1, 15, 14, 7, 19, 0}},
    {"Overworld", {27, 25, 4, 35, 10, 28, 0}},
    {"Nether", {27, 23, 4, 34, 12, 28, 0}},
    {"End", {13, 24, 2, 19, 3, 30, 0}},
    {"Aether", {8, 7, 2, 17, 6, 21, 0}},
    {"Twilight Forest", {36, 33, 16, 25, 7, 14, 0}},
    {"Lost City", {13, 4, 27, 8, 19, 3, 0}},
    {"Glacio", {26, 20, 4, 36, 9, 27, 0}},
    {"ATM Mining", {25, 33, 20, 7, 37, 17, 0}},
    {"ATM Other", {12, 23, 36, 13, 21, 16, 0}},
    {"ATM Beyond", {27, 5, 2, 23, 17, 38, 0}},
    {"Alfeim", {4, 9, 13, 11, 20, 7, 0}},
    {"Everbright", {24, 23, 37, 26, 35, 12, 0}},
    {"Everdawn", {5, 7, 10, 16, 26, 21, 0}},
    {"Otherside", {4, 13, 27, 12, 24, 17, 0}},
    {"Undergarden", {2, 4, 6, 31, 21, 35, 0}},
    {"Voidscape", {26, 5, 4, 11, 2, 37, 0}},
    --Private Server Stuff (Custom Addresses)--
    {"Chulak Base", {18, 11, 28, 26, 24, 35, 9, 25, 0}},
    {"Spawn", {30, 17, 27, 28, 14, 25, 20, 2, 0}},
    {"Shama's old Home", {21, 9, 4, 25, 30, 8, 15, 26, 0}},
    {"Ancient City", {21, 15, 24, 25, 34, 26, 11, 28, 0}}
};
 
INTERFACE_TYPES = {
    "basic_interface",
    "crystal_interface",
    "advanced_crystal_interface"
};
 
FEEDBACK_TYPES = {};
    --defaults--
    FEEDBACK_TYPES[0] = {0, "INFO", "none"};
    FEEDBACK_TYPES[-1] = {-1, "ERROR", "unknown"};
    --Chevron/Symbol--
    FEEDBACK_TYPES[1] = {1, "INFO", "symbol_encoded"};
    FEEDBACK_TYPES[-2] = {-2, "ERROR", "symbol_in_address"};
    FEEDBACK_TYPES[-3] = {-3, "ERROR", "symbol_out_of_bounds"};
    FEEDBACK_TYPES[-4] = {-4, "ERROR", "encode_when_connected"};
    --Establishing Connection--
    FEEDBACK_TYPES[2] = {2, "INFO", "connection_established.system_wide"};
    FEEDBACK_TYPES[3] = {3, "INFO", "connection_established.interstellar"};
    FEEDBACK_TYPES[4] = {4, "INFO", "connection_established.intergalactic"};
    --Errors--
    FEEDBACK_TYPES[-5] = {-5, "ERROR", "incomplete_address"};
    FEEDBACK_TYPES[-6] = {-6, "ERROR", "invalid_address"};
    FEEDBACK_TYPES[-7] = {-7, "ERROR", "not_enough_power"};
    FEEDBACK_TYPES[-8] = {-8, "ERROR", "self_obstructed"};
    FEEDBACK_TYPES[-9] = {-9, "ERROR", "target_obstructed"};
    FEEDBACK_TYPES[-10] = {-10, "ERROR", "self_dial"};
    FEEDBACK_TYPES[-11] = {-11, "ERROR", "same_system_dial"};
    FEEDBACK_TYPES[-12] = {-12, "ERROR", "already_connected"};
    FEEDBACK_TYPES[-13] = {-13, "ERROR", "no_galaxy"};
    FEEDBACK_TYPES[-14] = {-14, "ERROR", "no_dimensions"};
    FEEDBACK_TYPES[-15] = {-15, "ERROR", "no_stargates"};
    FEEDBACK_TYPES[-16] = {-16, "ERROR", "target_restricted"};
    FEEDBACK_TYPES[-17] = {-17, "ERROR", "invalid_8_chevron_address"};
    FEEDBACK_TYPES[-18] = {-18, "ERROR", "invalid_system_wide_connection"};
    FEEDBACK_TYPES[-19] = {-19, "ERROR", "whitelisted_target"};
    FEEDBACK_TYPES[-20] = {-20, "ERROR", "whitelisted_self"};
    FEEDBACK_TYPES[-21] = {-21, "ERROR", "blacklisted_target"};
    FEEDBACK_TYPES[-22] = {-22, "ERROR", "blacklisted_self"};
    --Wormhole--
    FEEDBACK_TYPES[5] = {5, "INFO", "wormhole.transport_successful"};
    FEEDBACK_TYPES[6] = {6, "INFO", "wormhole.entity_destroyed"};
    --End Connection--
    FEEDBACK_TYPES[7] = {7, "INFO", "connection_ended.disconnect"};
    FEEDBACK_TYPES[8] = {8, "INFO", "connection_ended.point_of_origin"};
    FEEDBACK_TYPES[9] = {9, "INFO", "connection_ended.stargate_network"};
    FEEDBACK_TYPES[10] = {10, "INFO", "connection_ended.autoclose"};
    FEEDBACK_TYPES[-23] = {-23, "ERROR", "exceeded_connection_time"};
    FEEDBACK_TYPES[-24] = {-24, "ERROR", "ran_out_of_power"};
    FEEDBACK_TYPES[-25] = {-25, "ERROR", "connection_rerouted"};
    FEEDBACK_TYPES[-26] = {-26, "ERROR", "wrong_disconnect_side"};
    FEEDBACK_TYPES[-27] = {-27, "ERROR", "connection_forming"};
    FEEDBACK_TYPES[-28] = {-28, "ERROR", "stargate_destroyed"};
    FEEDBACK_TYPES[-29] = {-29, "ERROR", "could_not_reach_target_stargate"};
    FEEDBACK_TYPES[-30] = {-30, "ERROR", "interrupted_by_incoming_connection"};
    --Milky Way--
    FEEDBACK_TYPES[11] = {11, "INFO", "chevron_opened"};
    FEEDBACK_TYPES[12] = {12, "INFO", "rotating"};
    FEEDBACK_TYPES[-31] = {-31, "INFO", "rotation_blocked"};
    FEEDBACK_TYPES[-32] = {-32, "INFO", "not_rotating"};
    FEEDBACK_TYPES[13] = {13, "INFO", "rotation_stopped"};
    FEEDBACK_TYPES[-33] = {-33, "ERROR", "chevron_already_opened"};
    FEEDBACK_TYPES[-34] = {-34, "ERROR", "chevron_already_closed"};
    FEEDBACK_TYPES[-35] = {-35, "ERROR", "chevron_not_raised"};
    FEEDBACK_TYPES[-36] = {-36, "ERROR", "cannot_encode_point_of_origin"};
 
STARGATE_TYPES = {
    "sgjourney:classic_stargate",
    "sgjourney:milky_way_stargate",
    "sgjourney:pegasus_stargate",
    "sgjourney:universe_stargate",
    "sgjourney:tollan_stargate"
};
 
function clearScreen()
    term.clear();
    term.setCursorPos(1, 1);
end
clearScreen();
 
--Function argument calls--
local arg = {...};
isFastDial = false;
for _,v in pairs(arg) do
    if v == "--fast" or v == "-f" then
        isFastDial = true;
    elseif v then
        error("Bad flag [" .. v .. "] failed to initialise", 0);
    end
end
 
--Find the proper interface--
print("Checking for \"" .. INTERFACE_TYPES[1] .. "\"");
interfaceType = INTERFACE_TYPES[1];
interface = peripheral.find(interfaceType);
if interface == nil then
    print("\"" .. INTERFACE_TYPES[1] .. "\" was not found attempting to find another");
 
    print("Checking for \"" .. INTERFACE_TYPES[2] .. "\"");
    interfaceType = INTERFACE_TYPES[2];
    interface = peripheral.find(interfaceType);
elseif interface == nil then
    print("\"" .. INTERFACE_TYPES[2] .. "\" was not found attempting to find another");
 
    print("Checking for \"" .. INTERFACE_TYPES[3] .. "\"");
    interfaceType = INTERFACE_TYPES[3];
    interface = peripheral.find(interfaceType);
elseif interface == nil then
    print("\"" .. INTERFACE_TYPES[3] .. "\" was not found attempting to find another");
 
    error("No interfaces were found", 0);
end
 
print("\"" .. interfaceType .. "\" was found");
StargateType = interface.getStargateType();
print("interface Type : " .. interfaceType);
print("Stargate Type : " .. StargateType);
 
print("\"");
 
--Check if selected stargate and flags can be used by current interface--
if (isFastDial == true or StargateType ~= STARGATE_TYPES[2]) and interfaceType == INTERFACE_TYPES[1] then
    error("\"" .. INTERFACE_TYPES[1] .. "\" can only be used with \"" .. STARGATE_TYPES[2] "\" in default manual dial mode", 0);
end
 
--Close Stargate and/or Reset Cheverons--
function resetStargate()
 
    if interface.isStargateConnected() then
        interface.disconnectStargate();
        os.sleep(2.75);
    else
        interface.disconnectStargate();
    end
end
 
--Call an address and try to make a connection--
function Dial(address)
    resetStargate();
    local addressLength = #address;
 
    if StargateType ~= STARGATE_TYPES[4] then
        if addressLength == 8 then
            interface.setChevronConfiguration({1, 2, 3, 4, 6, 7, 8, 5});
        elseif addressLength == 9 then
            interface.setChevronConfiguration({1, 2, 3, 4, 5, 6, 7, 8});
        end
    end
 
    local start = interface.getChevronsEngaged() + 1;
 
    if StargateType == STARGATE_TYPES[2] and isFastDial == false then
        for chevron = start,addressLength,1
        do
            local symbol = address[chevron];
 
            if chevron % 2 == 0 then
                interface.rotateClockwise(symbol);
            else
                interface.rotateAntiClockwise(symbol);
            end
 
            while(not interface.isCurrentSymbol(symbol))
            do
                os.sleep(0);
            end
 
            interface.endRotation();
 
            os.sleep(1);
            interface.openChevron();
 
            os.sleep(0.5);
            interface.closeChevron();
            print("Chevron[" .. chevron .. "] Engaged !!!");
            sleep(0.25);
        end 
    else
        for chevron = start,addressLength,1
        do
            local symbol = address[chevron];
            interface.engageSymbol(symbol);
            print("Chevron[" .. chevron .. "] Engaged !!!");
            os.sleep(0.25);
        end
        print(interface.getRecentFeedback());
    end
end
 
--Menu Selection--
addresses_length = #ADDRESSES;
page_size = 15;
addresses_book_size = math.ceil(addresses_length / page_size);
addresses_book = {};
index = 1;
for i = 1, addresses_book_size, 1 do
    addresses_book[i] = {};
    for j = 1, page_size, 1 do
        if index > addresses_length then
            break;
        end
        addresses_book[i][j] = {index, ADDRESSES[index][1]};
        index = index + 1;
    end
end
selected_page = 1;
 
while(true)
do
    clearScreen();
    for k,v in ipairs(addresses_book[selected_page]) do
        print(v[1] .. " : " .. v[2]);
    end
    print("\nYou are at Page[" .. selected_page .. "] of [" .. addresses_book_size .. "]\nTo select a new page type (n) or (p)");
 
    --Wait for Player input--
    input_string = io.read();
    os.sleep(0);
 
    if input_string == "next" or input_string == "n" then
        if selected_page < addresses_book_size then
            selected_page = selected_page + 1;
        end
    end
 
    if input_string == "previous" or input_string == "p" then
        if selected_page > 1 then
            selected_page = selected_page - 1;
        end
    end
 
    input_number = tonumber(input_string);
    if input_number ~= nil then
        break;
    end
end
 
if input_number < 1 or input_number > addresses_length then
    error("Entered value is incorrect", 0);
end
 
clearScreen();
print("You entered [" .. input_number .. "] dialing : " .. ADDRESSES[input_number][1] .. "");
 
if #ADDRESSES[input_number][2] > 7 and interfaceType == INTERFACE_TYPES[1] then
    clearScreen();
    print("Cannot dial 8 or 9 chevron address with \"" .. INTERFACE_TYPES[1] .. "\" please upgrade to \"" .. INTERFACE_TYPES[2] .. "\" or \"" .. INTERFACE_TYPES[3] .. "\"");
    error("Program Exit", 0);
end
 
Dial(ADDRESSES[input_number][2]);