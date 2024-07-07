local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core
end)

local playerKills = {}

RegisterCommand(Config.Command.Name, function(source, args, rawCommand)
    local User = VORPcore.getUser(source)
    local Character = User.getUsedCharacter
    local area = tonumber(args[1])

    if not area or not Config.Areas[area] then
        TriggerClientEvent('vorp:NotifyLeft', source, 'Mission', Config.Locale.areaNotFound, 'menu_textures', 'stamp_locked', 5000)
        return
    end

    local coords = GetEntityCoords(GetPlayerPed(source))

    if Config.Command.Access == 'all' then
        TriggerClientEvent('untamed_raids:startMission', source, area, coords)
    elseif Config.Command.Access == 'group' then
        if User and User.group and has_value(Config.Command.AllowedGroups, User.group) then
            TriggerClientEvent('untamed_raids:startMission', source, area, coords)
        else
            TriggerClientEvent('vorp:NotifyLeft', source, 'Mission', Config.Locale.accessDenied, 'menu_textures', 'stamp_locked', 5000)
        end
    elseif Config.Command.Access == 'job' then
        if Character and Character.job and has_value(Config.Command.AllowedJobs, Character.job) then
            TriggerClientEvent('untamed_raids:startMission', source, area, coords)
        else
            TriggerClientEvent('vorp:NotifyLeft', source, 'Mission', Config.Locale.accessDenied, 'menu_textures', 'stamp_locked', 5000)
        end
    end

    playerKills = {} -- Reset player kills for new mission
    if Config.Debug then print("Mission started for area " .. area) end
end, false)

function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

RegisterServerEvent('untamed_raids:rewardPlayers')
AddEventHandler('untamed_raids:rewardPlayers', function(coords)
    local players = GetPlayers()

    for _, playerId in ipairs(players) do
        local playerCoords = GetEntityCoords(GetPlayerPed(playerId))
        if Config.Debug then print("Checking player " .. playerId .. " at coords " .. tostring(playerCoords)) end
        if #(coords - playerCoords) < Config.Reward.Area then
            if Config.Debug then print("Player " .. playerId .. " is within 100 units of coords " .. tostring(coords)) end
            local User = VORPcore.getUser(playerId)
            local Character = User.getUsedCharacter

            if Config.Reward.Enabled then
                if Config.Reward.Type == 'money' then
                    Character.addCurrency(0, Config.Reward.Amount)
                    TriggerClientEvent('vorp:NotifyLeft', playerId, 'Mission', Config.Locale.missionCompleteMoney .. Config.Reward.Amount, 'menu_textures', 'stamp_locked', 5000)
                elseif Config.Reward.Type == 'item' then
                    local canCarry = exports.vorp_inventory:canCarryItem(playerId, Config.Reward.Item, Config.Reward.ItemQuantity)
                    if canCarry then
                        exports.vorp_inventory:addItem(playerId, Config.Reward.Item, Config.Reward.ItemQuantity)
                        TriggerClientEvent('vorp:NotifyLeft', playerId, 'Mission', Config.Locale.missionCompleteItem .. Config.Reward.ItemQuantity .. ' ' .. Config.Reward.Item, 'menu_textures', 'stamp_locked', 5000)
                    else
                        TriggerClientEvent('vorp:NotifyLeft', playerId, 'Mission', Config.Locale.cantCarry .. Config.Reward.Item, 'menu_textures', 'stamp_locked', 5000)
                    end
                elseif Config.Reward.Type == 'both' then
                    Character.addCurrency(0, Config.Reward.Amount)
                    local canCarry = exports.vorp_inventory:canCarryItem(playerId, Config.Reward.Item, Config.Reward.ItemQuantity)
                    if canCarry then
                        exports.vorp_inventory:addItem(playerId, Config.Reward.Item, Config.Reward.ItemQuantity)
                        TriggerClientEvent('vorp:NotifyLeft', playerId, 'Mission', Config.Locale.missionCompleteBoth .. Config.Reward.ItemQuantity .. ' ' .. Config.Reward.Item .. Config.Locale.missionCompleteBoth2 .. Config.Reward.Amount, 'menu_textures', 'stamp_locked', 5000)
                    else
                        TriggerClientEvent('vorp:NotifyLeft', playerId, 'Mission', Config.Locale.cantCarry .. Config.Reward.Item, 'menu_textures', 'stamp_locked', 5000)
                    end
                end
            end
        end
    end
end)

RegisterServerEvent('untamed_raids:notifyPlayers')
AddEventHandler('untamed_raids:notifyPlayers', function(notificationType, coords)
    local players = GetPlayers()
    local message = Config.Locale[notificationType]

    for _, playerId in ipairs(players) do
        local playerCoords = GetEntityCoords(GetPlayerPed(playerId))
        if #(coords - playerCoords) < 100.0 then
            TriggerClientEvent('untamed_raids:notify', playerId, message)
        end
    end
end)
