ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('xkrz_dumpsterdive:reward', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local wuerfel = math.random(1, 6)

    if xPlayer then
        if wuerfel == 3 or wuerfel == 4 then
            local randomItem = Config.Items[math.random(#Config.Items)]
            local quantity = math.random(#Config.Items)
            local itemLabel = ESX.GetItemLabel(randomItem)

            if xPlayer.canCarryItem(randomItem, quantity) then
                xPlayer.addInventoryItem(randomItem, quantity) 
                cb(true, itemLabel, quantity)
            else
                cb(false)
            end
        else
            if Config.EnableFood then 
                if wuerfel == 2 then
                    local randomFood = Config.Food[math.random(#Config.Food)]
                    local quantity = math.random(#Config.Food)
                    local itemLabel = ESX.GetItemLabel(randomFood)

                    if xPlayer.canCarryItem(randomFood, quantity) then
                        xPlayer.addInventoryItem(randomFood, quantity)
                        cb(true, itemLabel, quantity)
                    else
                        cb(false)
                    end
                else
                    cb(false)
                end
            else
                cb(false)
            end
        end
    else
        cb(false)
    end
end)
