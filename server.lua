local Sounds = {}

function Play(coords, soundName, volume, radius, uniqueId)
    local index = GetNextSoundIndex(uniqueId)
    if uniqueId == nil then
        uniqueId = index
    end
    Sounds[index] = uniqueId
    TriggerClientEvent("xyz-3dsound:client:play", -1, index, coords, soundName, volume, radius, Sounds[index])
end

function Pause(uniqueId)
    local index = ReturnSoundIndex(uniqueId)
    TriggerClientEvent("xyz-3dsound:client:pause", -1, index)
end

function Resume(uniqueId)
    local index = ReturnSoundIndex(uniqueId)
    TriggerClientEvent("xyz-3dsound:client:resume", -1, index)
end

function UpdateCoords(uniqueId, coords)
    local index = ReturnSoundIndex(uniqueId)
    TriggerClientEvent("xyz-3dsound:client:updateCoords", -1, index, coords)
end

function Delete(uniqueId)
    local index = ReturnSoundIndex(uniqueId)
    Sounds[index] = nil
    TriggerClientEvent("xyz-3dsound:client:stop", -1, index)
end

function GetNextSoundIndex(uniqueId)
    local i = 1
    while Sounds[i] ~= nil do
        if Sounds[i] == uniqueId then break end
        i = i + 1
    end
    return i
end

function ReturnSoundIndex(uniqueId)
    for k, v in pairs(Sounds) do
        if uniqueId == v then
            return k
        end
    end
end

exports("Play", Play);
exports("Pause", Pause);
exports("Resume", Resume);
exports("UpdateCoords", UpdateCoords);
exports("Delete", Delete);