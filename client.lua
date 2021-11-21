local Sounds = {}
local emittersPlaying = 0

--[[ Citizen.CreateThread(function()
    while true do
        print(emittersPlaying)
        Citizen.Wait(1000)
    end
end) ]]

function loop()
    local ped = PlayerPedId()
    while emittersPlaying > 0 do
        emittersPlaying = 0
        local coords = GetEntityCoords(ped)
        for k, v in pairs(Sounds) do
            if v.playing then
                local distanceVolumeMultiplier = (v.vol / v.dist)
                local distance = #(coords - vector3(v.pos.x, v.pos.y, v.pos.z))
                local distanceVolume = v.vol - (distance * distanceVolumeMultiplier)
                local pcoords = {x = coords.x, y = coords.y, z = coords.z}
                local camRot = rot_to_direction(GetGameplayCamRot(0))
                if v.playing then
                    emittersPlaying = emittersPlaying + 1
                end
                SendNUIMessage({submissionType = "updateVolume", volume = distanceVolume, playerPos = coords, camDir = {x = camRot.x, y = camRot.y, z = camRot.z}, soundIndex = k})
            end
        end
        Citizen.Wait(250)
    end
end

RegisterNetEvent("xyz-3dsound:client:play")
AddEventHandler("xyz-3dsound:client:play", function(index, coords, soundName, volume, radius, uniqueId)
    local distanceVolumeMultiplier = (volume / radius)
    local distance = Vdist(GetEntityCoords(PlayerPedId()), coords.x, coords.y, coords.z)
    local distanceVolume = volume - (distance * distanceVolumeMultiplier)

    local x, y, z, heading = table.unpack(coords)

    Sounds[index] = {pos = coords, vol = volume, dist = radius, playing = true}
    SendNUIMessage({submissionType = "sendSound", volume = volume, submissionFile = soundName, soundIndex = index, pos = coords})
    if emittersPlaying == 0 then
        emittersPlaying = 1
        loop()
    end
end)

RegisterNUICallback("discardSound", function(data)
    if Sounds[data.index] ~= nil then
        Sounds[data.index].playing = false
    end
end)

RegisterNetEvent("xyz-3dsound:client:pause")
AddEventHandler("xyz-3dsound:client:pause", function(index)
    if Sounds[index] ~= nil then
        SendNUIMessage({submissionType = "pause", soundIndex = index})
    end
end)

RegisterNetEvent("xyz-3dsound:client:resume")
AddEventHandler("xyz-3dsound:client:resume", function(index)
    if Sounds[index] ~= nil then
        Sounds[index].playing = true
        SendNUIMessage({submissionType = "resume", soundIndex = index})
        if emittersPlaying == 0 then
            emittersPlaying = 1
            loop()
        end
    end
end)

RegisterNetEvent("xyz-3dsound:client:updateCoords")
AddEventHandler("xyz-3dsound:client:updateCoords", function(index, coords)
    if Sounds[index] ~= nil then
        Sounds[index].pos = coords
        SendNUIMessage({submissionType = "updateCoords", soundIndex = index, pos = coords})
    end
end)

RegisterNetEvent("xyz-3dsound:client:stop")
AddEventHandler("xyz-3dsound:client:stop", function(index)
    if Sounds[index] ~= nil then
        Sounds[index].playing = false
        SendNUIMessage({submissionType = "stop", soundIndex = index})
    end
end)

function rot_to_direction(rot)
    local radiansZ = rot.z * 0.0174532924;
    local radiansX = rot.x * 0.0174532924;
    local num = math.abs(math.cos(radiansX));
    local dir = {};
    dir.x = (-math.sin(radiansZ)) * num;
    dir.y = (math.cos(radiansZ)) *  num;
    dir.z = math.sin(radiansX);
    return dir;
end