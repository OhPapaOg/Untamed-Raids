Config = {}

Config.Debug = false -- Set true if you want debug prints.

Config.Command = {
    Name = 'getclapped', -- Command to start the mission. To select an area to spawn in type /commandName areaNumber 
    Access = 'job', -- Options: 'all', 'group', 'job'
    AllowedGroups = {'admin', 'moderator'}, -- Groups that can use the command (if Access is 'group')
    AllowedJobs = {'police', 'sheriff'} -- Jobs that can use the command (if Access is 'job')
}

Config.Reward = { 
    Enabled = true, -- Enable reward
    Area = 100.0, -- -- rewards everyone in the radius
    Type = 'both', -- Type of reward: 'money', 'item', or 'both'
    Amount = 100, -- Amount of money
    Item = 'goldbar', -- Item to reward (if Type is 'item' or 'both')
    ItemQuantity = 1 -- Quantity of items to reward (if Type is 'item' or 'both')
}
Config.Areas = {
    [1] = { -- Area Number
        enemyWaves = {
            [1] = {
                enemies = {
                    {model = "s_m_m_army_01", coords = vector4(-243.8, 788.43, 119.66, 125.24), weapon = "WEAPON_REPEATER_HENRY"},
                    {model = "s_m_m_army_01", coords = vector4(-248.03, 778.43, 118.1, 125.24), weapon = "WEAPON_REPEATER_HENRY"}
                }
            },
            [2] = {
                enemies = {
                    {model = "s_m_m_army_01", coords = vector4(-247.43, 805.92, 121.5, 183.52), weapon = "WEAPON_REPEATER_HENRY"},
                    {model = "s_m_m_army_01", coords = vector4(-255.16, 811.0, 120.39, 183.52), weapon = "WEAPON_REPEATER_HENRY"}
                }
            },
        }
    },
    [2] = {
        enemyWaves = {
            [1] = {
                enemies = {
                    {model = "s_m_m_army_01", coords = vector4(-213.09, 622.23, 113.26, 125.24), weapon = "WEAPON_REPEATER_HENRY"},
                    {model = "s_m_m_army_01", coords = vector4(-209.48, 627.64, 113.17, 125.24), weapon = "WEAPON_REPEATER_HENRY"}
                    -- add more if you want.
                }
            },
            [2] = {
                enemies = {
                    {model = "s_m_m_army_01", coords = vector4(-198.43, 637.4, 113.17, 183.52), weapon = "WEAPON_REPEATER_HENRY"},
                    {model = "s_m_m_army_01", coords = vector4(-189.97, 646.25, 113.4, 183.52), weapon = "WEAPON_REPEATER_HENRY"}
                    -- add more if you want.
                }
            },
            -- Add more waves if you'd like. Use same format.
        }
    },
     -- Add more Areas if you'd like. Use same format.
}

Config.Locale = {
    missionCompleteMoney = 'You received $',
    missionCompleteItem = 'You received ',
    missionCompleteBoth = 'You received ',
    missionCompleteBoth2 = ' and $',
    cantCarry = 'You can\'t carry more ',
    notifyTitle = "~e~Hey Listen",
    ambush = 'You are being ambushed!',
    complete = 'You cleared out the bandits!',
    accessDenied = 'You do not have permission to start this mission.',
    areaNotFound = 'Area not found!'
}
