ESX = exports['es_extended']:getSharedObject()
searching = false
searchedDumpsters = {}

exports['qb-target']:AddTargetModel(Config.Dumpsters,  {
    options = {
      {
        type = 'client',
        event = 'xkrz_dumpster:entityCheck',
        icon = "fa-solid fa-dumpster",
        label = "Durchsuchen",
      },
    },
    distance = 1.5,
})

RegisterNetEvent('xkrz_dumpster:entityCheck')
AddEventHandler('xkrz_dumpster:entityCheck', function()
        local sleep = 500
        local xPlayer = PlayerPedId()
        local xPlayerCoords = GetEntityCoords(xPlayer)

        if searching then DisableControls() end 
        for i = 1, #Config.Dumpsters do
            local entity = GetClosestObjectOfType(xPlayerCoords, 0.8, GetHashKey(Config.Dumpsters[i]), false, false, false)
            local entityCoords = GetEntityCoords(entity)
            if DoesEntityExist(entity) then
                sleep = 5                
                if not searchedDumpsters[entity] then
                    Search(entity)
                else
                    lib.notify({
                        title = 'Wurde bereits durchsucht.',
                        position = 'top',
                        type = 'inform'
                    })
                end
            end
        end
    Citizen.Wait(sleep)
end)

function Search(entity)
    searching = true
    searchedDumpsters[entity] = true
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true) 
    lib.progressCircle({
        duration = math.random(4000, 8000),
        position = 'bottom',
        label = 'Durchsuche...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    })
    ESX.TriggerServerCallback('xkrz_dumpsterdive:reward', function(found, object, quantity)
        if found then
            lib.notify({
                title = 'Du hast ' .. quantity .. "x " .. object .. ' gefunden.',
                position = 'top',
                type = 'success'
            })
        else
            lib.notify({
                title = 'Leer...',
                position = 'top',
                type = 'error'
            })
        end
    end)
    searching = false
    ClearPedTasks(PlayerPedId())
end

function DisableControls()
    DisableControlAction(0, 73) 
    DisableControlAction(0, 323) 
    DisableControlAction(0, 288) 
    DisableControlAction(0, 289) 
    DisableControlAction(0, 170) 
    DisableControlAction(0, 166) 
    DisableControlAction(0, 167)
end
