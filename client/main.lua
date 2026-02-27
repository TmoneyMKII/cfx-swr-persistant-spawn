local resourceName = GetCurrentResourceName()
local configRaw = LoadResourceFile(resourceName, 'config.json')
local config = json.decode(configRaw)

local firstSpawnHandled = false

local function saveCurrentPosition()
    local ped = PlayerPedId()
    if ped == 0 or not DoesEntityExist(ped) then
        return
    end

    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)

    TriggerServerEvent('persistentspawn:server:saveSpawn', {
        x = coords.x,
        y = coords.y,
        z = coords.z,
        heading = heading
    })
end

RegisterNetEvent('persistentspawn:client:applySpawn', function(spawn)
    if not spawn or not spawn.x or not spawn.y or not spawn.z then
        return
    end

    local ped = PlayerPedId()

    DoScreenFadeOut(250)
    while not IsScreenFadedOut() do
        Wait(0)
    end

    RequestCollisionAtCoord(spawn.x + 0.0, spawn.y + 0.0, spawn.z + 0.0)
    SetEntityCoordsNoOffset(ped, spawn.x + 0.0, spawn.y + 0.0, spawn.z + 0.0, false, false, false)
    SetEntityHeading(ped, (spawn.heading or 0.0) + 0.0)

    Wait(250)
    DoScreenFadeIn(250)
end)

AddEventHandler('playerSpawned', function()
    if firstSpawnHandled then
        return
    end

    firstSpawnHandled = true
    TriggerServerEvent('persistentspawn:server:requestSpawn')
end)

CreateThread(function()
    local interval = (config and config.autoSaveIntervalMs) or 30000

    while true do
        Wait(interval)
        saveCurrentPosition()
    end
end)

AddEventHandler('onResourceStop', function(stoppedResourceName)
    if stoppedResourceName ~= resourceName then
        return
    end

    saveCurrentPosition()
end)
