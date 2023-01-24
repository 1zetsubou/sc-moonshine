local QBCore = exports['qb-core']:GetCoreObject()
--enter place

CreateThread(function()
    exports['qb-target']:SpawnPed({
        model = 'a_m_m_hillbilly_01', -- This is the ped model that is going to be spawning at the given coords
        coords = vector4(1388.37, 3615.65, 38.92, 27.56), -- This is the coords that the ped is going to spawn at, always has to be a vector4 and the w value is the heading
        minusOne = true, -- Set this to true if your ped is hovering above the ground but you want it on the ground (OPTIONAL)
        freeze = true, -- Set this to true if you want the ped to be frozen at the given coords (OPTIONAL)
        invincible = true, -- Set this to true if you want the ped to not take any damage from any source (OPTIONAL)
        blockevents = true, -- Set this to true if you don't want the ped to react the to the environment (OPTIONAL)
          target = { -- This is the target options table, here you can specify all the options to display when targeting the ped (OPTIONAL)
          useModel = false, -- This is the option for which target function to use, when this is set to true it'll use AddTargetModel and add these to al models of the given ped model, if it is false it will only add the options to this specific ped
          options = { -- This is your options table, in this table all the options will be specified for the target to accept
            { -- This is the first table with options, you can make as many options inside the options table as you want
              num = 1, -- This is the position number of your option in the list of options in the qb-target context menu (OPTIONAL)
              type = "client", -- This specifies the type of event the target has to trigger on click, this can be "client", "server", "command" or "qbcommand", this is OPTIONAL and will only work if the event is also specified
              event = "qb-moonshine:EnterMWarehouse", -- This is the event it will trigger on click, this can be a client event, server event, command or qbcore registered command, NOTICE: Normal command can't have arguments passed through, QBCore registered ones can have arguments passed through
              icon = 'fas fa-atom', -- This is the icon that will display next to this trigger option
              label = 'Talk To Kleetuz Fatfucc', -- This is the label of this option which you would be able to click on to trigger everything, this has to be a string
              targeticon = 'fas fa-atom', -- This is the icon of the target itself, the icon changes to this when it turns blue on this specific option, this is OPTIONAL
            
            }
          },
          distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
        },

      })
--exit place

    
   
   
    
    exports["qb-target"]:AddBoxZone("leavelab", vector3(1398.95, 3608.34, 38.94), 1, 1, {
        name = "leavelab",
        heading = 0,
        debugPoly = false,
        minZ = 35.0,
        maxZ = 40.0,
    }, {
        options = {
            {
                type = "client",
                event = "qb-moonshine:ExitMWarehouse",
                icon = "fas fa-lock",
                label = Lang:t("target.keypad"),
                --job = "cokecutter", -- Remove this line if you do not want a job check.
            },
        },
    distance = 3.5
    })



--process mash

    exports["qb-target"]:AddBoxZone("makemash", vector3(1390.98, 3606.3, 38.73), 7.65, 1.2, {
        name = "makemash",
        heading = 90,
        debugPoly = false,
        minZ = 30.39,
        maxZ = 40.44,
    }, {
        options = {
            {
                type = "client",
                event = "qb-moonshine:processMash",
                icon = "fas fa-weight-scale",
                label = Lang:t("target.cokepowdercut"),
                --job = "cokecutter", -- Remove this line if you do not want a job check.
            },
        },
    distance = 3.5
    })

    --bottle 
    exports["qb-target"]:AddBoxZone("bottlemoonshine", vector3(1389.83, 3608.71, 38.94), 2.6, 1.0, {
        name = "bottlemoonshine",
        heading = 90,
        debugPoly = false,
        minZ = 30.0,
        maxZ = 40.0,
    }, {
        options = {
            {
                type = "client",
                event = "qb-moonshine:processMoonshine",
                icon = "fas fa-weight-scale",
                label = Lang:t("target.bagging"),
                --job = "cokecutter", -- Remove this line if you do not want a job check.
            },
        },
    distance = 3.5
    })
    
-- picking

    exports['qb-target']:AddTargetModel("prop_plant_cane_02a", {
        options = {
            {
                type = "client",
                event = "qb-moonshine:pickSugarLeaves",
                icon = "fas fa-leaf",
                label = Lang:t("target.pickCocaLeaves"),
            },
        },
        distance = 4.0
    })
    
end)
