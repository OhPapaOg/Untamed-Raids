RegisterNetEvent('untamed_raids:startMission')
AddEventHandler('untamed_raids:startMission', function(area, coords)
    TriggerServerEvent('untamed_raids:notifyPlayers', 'ambush', coords)
    TriggerEvent('untamed_raids:spawnEnemies', Config.Areas[area])
end)

RegisterNetEvent('untamed_raids:spawnEnemies')
AddEventHandler('untamed_raids:spawnEnemies', function(area)
    local waveIndex = 1
    local enemyEntities = {}
    local missionActive = true
    local missionCoords = area.enemyWaves[1].enemies[1].coords

    local spawnWave = function(wave)
        for _, enemyData in ipairs(wave.enemies) do
            LoadModel(enemyData.model)
            local enemy = CreatePed(GetHashKey(enemyData.model), enemyData.coords.x, enemyData.coords.y, enemyData.coords.z, enemyData.coords.w, true, true)
            Citizen.InvokeNative(0x283978A15512B2FE, enemy, true)
            GiveWeaponToPed(enemy, GetHashKey(enemyData.weapon), 100, true, true)
            SetPedCombatAttributes(enemy, 46, true)
    
            local players = GetActivePlayers()
            for _, playerId in ipairs(players) do
                local playerPed = GetPlayerPed(playerId)
                local playerCoords = GetEntityCoords(playerPed)
                if #(vector3(enemyData.coords.x, enemyData.coords.y, enemyData.coords.z) - playerCoords) < Config.Reward.Area then
                    TaskCombatPed(enemy, playerPed, 0, 16)
                end
            end
    
            table.insert(enemyEntities, enemy)
        end
    end

    local checkWaveCompletion = function(wave)
        Citizen.CreateThread(function()
            while missionActive do
                Citizen.Wait(1000)
                local allDead = true
                for _, entity in pairs(enemyEntities) do
                    if DoesEntityExist(entity) and not IsPedDeadOrDying(entity) then
                        allDead = false
                        break
                    end
                end
                if allDead then
                    for _, entity in pairs(enemyEntities) do
                        if DoesEntityExist(entity) then
                            DeleteEntity(entity)
                        end
                    end
                    enemyEntities = {}
                    waveIndex = waveIndex + 1
                    if waveIndex <= #area.enemyWaves then
                        spawnWave(area.enemyWaves[waveIndex])
                    else
                        TriggerServerEvent('untamed_raids:notifyPlayers', 'complete', vector3(missionCoords.x, missionCoords.y, missionCoords.z))
                        TriggerServerEvent('untamed_raids:rewardPlayers', vector3(missionCoords.x, missionCoords.y, missionCoords.z))
                        missionActive = false
                        break
                    end
                end
            end
        end)
    end

    if #area.enemyWaves > 0 then
        spawnWave(area.enemyWaves[waveIndex])
        checkWaveCompletion(area.enemyWaves[waveIndex])
    end
end)

RegisterNetEvent('untamed_raids:notify')
AddEventHandler('untamed_raids:notify', function(message)
    TriggerEvent('vorp:ShowTopNotification',Config.Locale.notifyTitle, message, 5000)
end)

function LoadModel(model)
    while not HasModelLoaded(GetHashKey(model)) do
        RequestModel(GetHashKey(model))
        Citizen.Wait(10)
    end
end
