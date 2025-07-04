-- Function to move items from one barrel to the next in the list of connected barrels
function moveItems()
    -- Find all barrels connected via the modem
    local barrels = {}
    for _, peripheralSide in ipairs(peripheral.getNames()) do
        if peripheral.getType(peripheralSide) == "minecraft:barrel" then
            table.insert(barrels, peripheral.wrap(peripheralSide))
        end
    end

    -- Check if at least two barrels are found
    if #barrels < 2 then
        print("Error: At least two barrels are required.")
        return
    end

    -- Iterate through the barrels and move items from the current barrel to the next one
    for i = 1, #barrels - 1 do
        local barrel0 = barrels[i]
        local barrel1 = barrels[i + 1]

        -- Get the sides of the barrels (this assumes barrels are on adjacent sides like "left", "right", etc.)
        local barrel0Side = peripheral.getName(barrel0)
        local barrel1Side = peripheral.getName(barrel1)

        print("Moving items from Barrel " .. i .. " to Barrel " .. (i + 1))

        -- List all items in Barrel 0
        local items = barrel0.list()
        if not next(items) then
            print("No items in Barrel " .. i .. " to move.")
            return
        end

        -- Iterate through items in Barrel 0 and move them to Barrel 1
        for slot, data in pairs(items) do
            print("Moving " .. data.name .. " from Barrel " .. i .. " to Barrel " .. (i + 1))

            -- Move item from Barrel 0 to Barrel 1
            local success = barrel0.pushItems(barrel1Side, slot, data.count)
            
            if success then
                print("Successfully moved " .. data.count .. " of " .. data.name)
            else
                print("Failed to move " .. data.name)
            end
        end
    end
end

-- Run the moveItems function
moveItems()

