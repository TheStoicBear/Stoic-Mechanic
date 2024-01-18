-- Define success chance for repairs
local successChance = 0.8
local raisedCar = nil
local isRaised = false
local vehpos = nil
local flWheelStand = nil
local frWheelStand = nil
local rlWheelStand = nil
local rrWheelStand = nil
local isMedicTending = false
-- Function to send chat bubble notifications for mech actions
function SendMechNotification(playerName, message)
    TriggerServerEvent('mech:SendMechNotification', playerName, message)
end

-- Check if the player is in a repair zone
function IsPlayerInRepairZone()
    local playerCoords = GetEntityCoords(GetPlayerPed(-1))

    for zoneName, zoneData in pairs(Config.Zones) do
        local distance = #(playerCoords - zoneData.coords)
        if distance <= zoneData.radius then
            return true
        end
    end

    return false
end

-- Register chat command /repair
RegisterCommand("cxrepair", function()
    local playerPed = GetPlayerPed(-1)
    local playerName = GetPlayerName(PlayerId())

    -- Permission check
    if Config.UseAcePerms then
        if IsAceAllowed and type(IsAceAllowed) == 'function' then
            if not IsAceAllowed(Config.MechPermission) then
                PlayerFailedToRepair(playerName, "You do not have permission to use this command.")
                return
            end
        elseif Config.UseND then
            local character = NDCore.getPlayer()
            if not character then
                PlayerFailedToRepair(playerName, "Failed to check mechanic job. Character data not available.")
                return
            end

            local hasMechanicJob = false
            for _, department in pairs(Config.MechJob) do
                if character.job == department then
                    hasMechanicJob = true
                    break
                end
            end

            if not hasMechanicJob then
                PlayerFailedToRepair(playerName, "You are not a mechanic.")
                return
            end
        end
    end

    -- Check if the player is in a repair zone
    if not IsPlayerInRepairZone() then
        SendMechNotification(playerName, "^1You are not in a repair zone.")
        return
    end

    -- Continue with repair logic
    local progressDuration = Config.repairTime
    local progressBarLabel = "Repairing..."
    local allowCancel = true

    lib.progressBar({
        duration = progressDuration,
        label = progressBarLabel,
        canCancel = allowCancel,
        dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3",
        clip = "machinic_loop_mechandplayer",
        lockX = true,
        lockY = true,
        lockZ = true,
        scenario = "PROP_HUMAN_BUM_BIN",
        prop = {
            model = GetHashKey("prop_tool_broom"),
            bone = 57005,
            pos = { x = 0.0, y = 0.0, z = 0.0 },
            rot = { x = 0.0, y = 0.0, z = 0.0 }
        },
        disable = {
            move = true,
            car = true,
            combat = true,
            mouse = true,
            sprint = true
        }
    })

    TriggerEvent('raisecar') -- Raise the car
    Citizen.Wait(1000)
    TriggerEvent('medictend', true)
    Citizen.Wait(Config.repairTime)
    TriggerEvent('lowercar', playerPed)
end, false)




-- Function to send chat bubble notifications for mech actions
function SendMechNotification(playerName, message)
    TriggerServerEvent('mech:SendMechNotification', playerName, message)
end

-- Function to notify when a player successfully repairs a vehicle
function PlayerRepaired(playerName)
    SendMechNotification(playerName, "^2Vehicle repaired successfully!")
end

-- Function to notify when a player fails to repair a vehicle
function PlayerFailedToRepair(playerName, reason)
    SendMechNotification(playerName, "^1Vehicle repair failed. " .. reason)
end


-- Function to trigger the MEDIC TEND animation
RegisterNetEvent('medictend')
AddEventHandler('medictend', function(startTend)
    local playerPed = GetPlayerPed(-1)

    if startTend then
        TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
        isMedicTending = true
    else
        ClearPedTasks(playerPed) -- Stop the animation
        isMedicTending = false
    end
end)

-- Function to raise the car
RegisterNetEvent('raisecar')
AddEventHandler('raisecar', function()
    local veh = getNearestVeh()
    local ped = GetPlayerPed(-1)

    if IsEntityAVehicle(veh) and not IsPedInAnyVehicle(ped, false) and not isRaised and IsVehicleSeatFree(veh, -1) and IsVehicleStopped(veh) then
        isRaised = true
        raisedCar = veh
        vehpos = GetEntityCoords(veh)

        -- Send a notification to server.lua for raising the car
        local playerName = GetPlayerName(PlayerId())
        SendMechNotification(playerName, "^5Raising the car for repair.")
        local model = 'xs_prop_x18_axel_stand_01a'

        FreezeEntityPosition(veh, true)
        vehpos = GetEntityCoords(veh)
        RequestModel(model)

        flWheelStand = CreateObject(GetHashKey(model), vehpos.x, vehpos.y, vehpos.z - 0.5, true, true, true)
        frWheelStand = CreateObject(GetHashKey(model), vehpos.x, vehpos.y, vehpos.z - 0.5, true, true, true)
        rlWheelStand = CreateObject(GetHashKey(model), vehpos.x, vehpos.y, vehpos.z - 0.5, true, true, true)
        rrWheelStand = CreateObject(GetHashKey(model), vehpos.x, vehpos.y, vehpos.z - 0.5, true, true, true)

        AttachEntityToEntity(flWheelStand, veh, 0, 0.5, 1.0, -0.8, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
        AttachEntityToEntity(frWheelStand, veh, 0, -0.5, 1.0, -0.8, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
        AttachEntityToEntity(rlWheelStand, veh, 0, 0.5, -1.0, -0.8, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
        AttachEntityToEntity(rrWheelStand, veh, 0, -0.5, -1.0, -0.8, 0.0, 0.0, 0.0, false, false, false, false, 0, true)

        Citizen.Wait(1250)
        SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.01, true, true, true)

        -- Remove doors, trunk, hood, and wheels
        RemoveVehicleDoors(veh)
        RemoveVehicleWheels(veh)
    end
end)


-- Function to lower the car, stop animation, and repair the vehicle
RegisterNetEvent('lowercar')
AddEventHandler('lowercar', function(playerPed)
    local veh = raisedCar

    if isRaised then
		-- Replace doors, trunk, hood, and wheels
        ReplaceVehicleDoors(veh)
        ReplaceVehicleWheels(veh)
        -- Repair the vehicle when lowering it
        RepairVehicle(veh)
        SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.175, true, true, true)

        Citizen.Wait(1000)
        SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.15, true, true, true)

        Citizen.Wait(1000)
        SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.125, true, true, true)

        Citizen.Wait(1000)
        SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.1, true, true, true)

        Citizen.Wait(1000)
        SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.075, true, true, true)

        Citizen.Wait(1000)
        SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.05, true, true, true)

        Citizen.Wait(1000)
        SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.025, true, true, true)
        Citizen.Wait(1000)
        SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.01, true, true, true)

        SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z, true, true, true)
        FreezeEntityPosition(veh, false)

        DeleteObject(flWheelStand)
        DeleteObject(frWheelStand)
        DeleteObject(rlWheelStand)
        DeleteObject(rrWheelStand)

        isRaised = false

        raisedCar = nil
        vehpos = nil
        flWheelStand = nil
        frWheelStand = nil
        rlWheelStand = nil
        rrWheelStand = nil

        -- Stop the animation if it's active
        if isMedicTending then
            TriggerEvent('medictend', false)
			TriggerServerEvent('deductRepairCost')
        end
    end
end)


-- Function to repair the vehicle
function RepairVehicle(vehicle, playerPed)
    -- Repair engine and body
    SetVehicleFixed(vehicle)
    SetVehicleDeformationFixed(vehicle)
    SetVehicleUndriveable(vehicle, false)
    SetVehicleEngineOn(vehicle, true, true)
    
    -- Clean the vehicle
    SetVehicleDirtLevel(vehicle, 0.0)

    -- Fix windows
    for i = 1, 13 do
        if IsVehicleWindowIntact(vehicle, i) then
            FixVehicleWindow(vehicle, i)
        end
    end

    -- Send a chat notification or perform any other desired action
    local playerName = GetPlayerName(PlayerId())
    PlayerRepaired(playerName)
end

-- Function to remove doors, trunk, hood, and wheels
function RemoveVehicleDoors(vehicle)
    for i = 0, 6 do
        if DoesVehicleHaveDoor(vehicle, i) then
            SetVehicleDoorBroken(vehicle, i, true)
        end
    end
end

-- Function to remove all wheels from the vehicle
function RemoveVehicleWheels(vehicle)
    local numWheels = GetVehicleNumberOfWheels(vehicle)
    for i = 0, numWheels - 1 do
        BreakOffVehicleWheel(vehicle, i, false, true, false, false)
    end
end

-- Function to replace doors, trunk, hood, and wheels
function ReplaceVehicleDoors(vehicle)
    for i = 0, 6 do
        if DoesVehicleHaveDoor(vehicle, i) then
            SetVehicleDoorBroken(vehicle, i, false)
        end
    end
end

-- Function to replace all wheels on the vehicle
function ReplaceVehicleWheels(vehicle)
    local numWheels = GetVehicleNumberOfWheels(vehicle)
    for i = 0, numWheels - 1 do
        SetVehicleTyreFixed(vehicle, i)
    end
end

-- Get the nearest vehicle function
function getNearestVeh()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 5.0, 0.0) -- Adjusted range
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
    return vehicleHandle
end

-- Initialize the script
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        -- Handle other events or tasks here if needed
    end
end)
