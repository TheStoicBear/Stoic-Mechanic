NDCore = exports["ND_Core"]:GetCoreObject()

-- Inside the event handler for 'mech:SendMechNotification'
RegisterNetEvent('mech:SendMechNotification')
AddEventHandler('mech:SendMechNotification', function(playerName, message)
    local imageUrl = Config.MechLogoURL -- Replace with your image URL
    local assignedTag = "[Mechanic]" -- Customize the tag as needed
    local formattedMessage = string.format('<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 3px;"><img src="%s" style="width: 30px; height: 30px; vertical-align: middle;"> <b>%s %s:</b> %s</div>', imageUrl, assignedTag, playerName, message)

    local sourcePlayerId = source -- Get the player ID of the player who triggered the event
    local sourcePlayerPed = GetPlayerPed(sourcePlayerId)
    local sourcePlayerCoords = GetEntityCoords(sourcePlayerPed)

    -- Iterate through all players to check their distance from the source player
    for _, playerId in ipairs(GetPlayers()) do
        local targetPlayerPed = GetPlayerPed(playerId)
        local targetPlayerCoords = GetEntityCoords(targetPlayerPed)
        local distance = #(sourcePlayerCoords - targetPlayerCoords)

        -- Customize the distance (e.g., 10.0) to your desired range
        if distance <= 10.0 then
            TriggerClientEvent('chat:addMessage', playerId, {
                template = formattedMessage,
                args = { playerName, message }
            })
        end
    end
end)


RegisterServerEvent('deductRepairCost')
AddEventHandler('deductRepairCost', function()
    local src = source
    local randomAmount = math.random(750, 7550)
    
    local player = NDCore.getPlayer(source)
    local success = player.deductMoney("cash", randomAmount, "Vehicle Repair Invoice")

    -- Notify the player about the deduction
    local playerName = GetPlayerName(src)
    local assignedTag = "[SYSTEM]" -- Customize the tag as needed
    local message = 'You have been charged $' .. randomAmount .. ' for vehicle repair.'
    
    local formattedMessage = string.format('<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 3px;"><b>%s %s:</b> %s</div>', assignedTag, playerName, message)

    -- Notify the player using a chat message with the formatted message
    TriggerClientEvent('chat:addMessage', src, {
        template = formattedMessage,
        args = { assignedTag, playerName, message }
    })
end)
