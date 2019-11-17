local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

ESX = nil
local hash = -573920724 --Driver Ped Hash
local vehicleHash = -713569950 --Vehicle hash

local ped = nil
local globalTaxi = nil
local stop = false
local loop = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterCommand('bus', function()
    TriggerEvent("chat:addMessage", { args = { "Event-Start!!" } })
    local playerPed = GetPlayerPed(-1)

    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(50)
    end
    while not HasModelLoaded(vehicleHash) do
        RequestModel(vehicleHash)
        Wait(50)
    end
    ped = CreatePed(4, hash, 911.24, -177.84, 74.29 + 2, 0.0, true, true)

    ESX.Game.SpawnVehicle(vehicleHash, vector3(307.54, -764.70, 29.2), 162.41, function(callback_vehicle)
        TaskWarpPedIntoVehicle(ped, callback_vehicle, -1)
        SetVehicleHasBeenOwnedByPlayer(callback_vehicle, true)
        globalTaxi = callback_vehicle
        SetEntityAsMissionEntity(globalTaxi, true, true)
        drive(115.81, -785.10, 31.31)
    end)
    while true do
        Citizen.Wait(100)
        if loop == true then
            drive(115.81, -785.10, 31.31)
        end
    end
end)

function drive(x, y, z)
    Citizen.Wait(math.random(10000, 30000))
    ESX.ShowHelpNotification('Ein Fahrer ist auf dem Weg zu Ihnen.')

    TaskVehicleDriveToCoordLongrange(ped, globalTaxi, x, y, z, 20.0, 524863, 5.0)
    --Nähe MP
    while stop == false do
        Citizen.Wait(10)
        local coordsped = GetEntityCoords(ped)
        if (GetDistanceBetweenCoords(coordsped, x, y, z, true) < 50) then
            stop = true
            Citizen.Wait(math.random(10000, 30000))
            ESX.ShowHelpNotification('Ein Fahrer ist auf dem Weg zu Ihnen.')
            TaskVehicleDriveToCoordLongrange(ped, globalTaxi, -149.1, -755.2, 33.6, 20.0, 524863, 5.0)
        end
    end
    stop = false
    while stop == false do
        Citizen.Wait(10)
        local coordsped = GetEntityCoords(ped)
        if (GetDistanceBetweenCoords(coordsped, -149.1, -755.2, 33.6, true) < 5) then
            stop = true
            ESX.ShowHelpNotification('Ein Fahrer ist auf dem Weg zu Ihnen.')
            TaskVehicleDriveToCoordLongrange(ped, globalTaxi, -174.57, -828.11, 30.29, 20.0, 524863, 1.0)
        end
    end
    stop = false
    --Arbeitsamt
    while stop == false do
        Citizen.Wait(10)
        local coordsped = GetEntityCoords(ped)
        if (GetDistanceBetweenCoords(coordsped, -174.57, -828.11, 30.29, true) < 50) then
            stop = true
            Citizen.Wait(math.random(10000,30000))
            ESX.ShowHelpNotification('Ein Fahrer ist auf dem Weg zu Ihnen.')
            TaskVehicleDriveToCoordLongrange(ped, globalTaxi, 408.06, -903.75, 29.37, 20.0, 524863, 5.0)
        end
    end
    stop = false
    --PD
    while stop == false do
        Citizen.Wait(10)
        local coordsped = GetEntityCoords(ped)
        if (GetDistanceBetweenCoords(coordsped, 408.06, -903.75, 29.37, true) < 50) then
            stop = true
            --Citizen.Wait(math.random(10000,30000))
            ESX.ShowHelpNotification('Ein Fahrer ist auf dem Weg zu Ihnen.')
            TaskVehicleDriveToCoordLongrange(ped, globalTaxi, 409.53, -755.039, 28.70, 20.0, 524863, 5.0)
        end
    end
    stop = false
    --Waypoint, um im Kreis zu fahren
    while stop == false do
        Citizen.Wait(10)
        local coordsped = GetEntityCoords(ped)
        if (GetDistanceBetweenCoords(coordsped, 409.53, -755.039, 28.70, 20.0, true) < 50) then
            stop = true
            ESX.ShowHelpNotification('Ein Fahrer ist auf dem Weg zu Ihnen.')
            TaskVehicleDriveToCoordLongrange(ped, globalTaxi, 307.54, -764.70, 29.2, 20.0, 524863, 5.0)
        end
    end
    stop = false
    while stop == false do
        Citizen.Wait(10)
        local coordsped = GetEntityCoords(ped)
        if (GetDistanceBetweenCoords(coordsped, 307.54, -764.70, 29.2, 20.0, true) < 50) then
            loop = true
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        local vehicle, distance = ESX.Game.GetClosestVehicle(coords)

        --print(distance)

        if distance < 7.0 and GetEntityModel(vehicle) == -713569950 and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
            ESX.ShowHelpNotification('Drücke ~INPUT_PICKUP~ um in den Bus einzusteigen.')
            if IsControlJustReleased(0, Keys['F']) and GetLastInputMethod(2) then
                --TaskEnterVehicle(GetPlayerPed(-1), vehicle, 1000, math.random(0,15), 2.0, 1, 0)
                TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, math.random(0, 15))
            end
        end
        --print(GetEntityModel(vehicle))
    end
end)