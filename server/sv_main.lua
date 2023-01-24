local QBCore = exports['qb-core']:GetCoreObject()

--- Returns the amount of cops online and on duty
--- @return amount number - amount of cops
local GetCopCount = function()
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for _, Player in pairs(players) do
        if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    return amount
end

--- Calculates the amount of cash rolls to launder
--- @return retval number - amount
local GetLaunderAmount = function()
    local cops = GetCopCount()
    if cops > 10 then cops = 10 end -- cap at 10 cops for no insane returns
    local min = 300 + (cops * 100) -- 300 base + 100 per cop minimum
    local max = 600 + (cops * 190) -- 600 base + 190 per cop minimum
    local retval = math.random(min, max)
    return retval
end

RegisterNetEvent('qb-moonshine:server:Reward', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        -- Cash
        local cash = Config.PaymentAmount
        Player.Functions.AddMoney("cash", cash, "oxy-money")

        -- Launder
        local launder = math.random(100)
        local item = Player.Functions.GetItemByName(Config.LaunderItem)
        if item and launder <= Config.LaunderChance then
            local amount = item.amount
            local removeAmount = GetLaunderAmount()
            if removeAmount > amount then removeAmount = amount end
            Player.Functions.RemoveItem(Config.LaunderItem, removeAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.LaunderItem], "remove", removeAmount)
            Wait(250)
            
            Player.Functions.AddMoney('cash', Config.LauderPay, 'shine-launder')
            TriggerClientEvent('QBCore:Notify', src, "You have laundered some money...", "success", 2500)
        end

        -- Oxy
        local oxy = math.random(100)
        if oxy <= Config.ShineChance then
            Player.Functions.AddItem(Config.ShineItem, 1, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.ShineItem], "add", 1)
        end

        -- Rare loot
        local rareLoot = math.random(100)
        if rareLoot <= Config.RareLoot then
            Player.Functions.AddItem(Config.RareLootItem, 1, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.RareLootItem], "add", 1)
        end
    end
end)

QBCore.Functions.CreateCallback('qb-moonshine:StartMoonshine', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.PlayerData.money.cash >= Config.StartShinePayment then
        local amount = GetCopCount()
        if amount >= Config.MinCops then
            Player.Functions.RemoveMoney('cash', Config.StartShinePayment, "oxy start")
            cb(true)
        else
            TriggerClientEvent('QBCore:Notify', src, "Not enough cops on duty..", "error",  2500)
            cb(false)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough money to start an oxyrun..", "error",  3500)
        cb(false)
    end
end)


--processing

local QBCore = exports['qb-core']:GetCoreObject()
--pick up sugar leaf
RegisterServerEvent('qb-moonshine:pickedUpSugarLeaf', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("sugar", 1) then 
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["sugar"], "add")
		TriggerClientEvent('QBCore:Notify', src, Lang:t("success.sugar"), "success")
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_sugar"), "error")
	end
end)
--process into sugar
RegisterServerEvent('qb-moonshine:processSugarLeaf', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('sugar', Config.MoonshineProcessing.SugarLeaf) then
		local sugaramount = math.random(2,7)
		if Player.Functions.AddItem('mash', sugaramount) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['sugar'], "remove", Config.MoonshineProcessing.SugarLeaf)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['mash'], "add", sugaramount)
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.coke"), "success")
		else
			Player.Functions.AddItem('sugar', Config.MoonshineProcessing.SugarLeaf)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_sugar"), "error")
	end
end)
--process into mash with corn and sugar
RegisterServerEvent('qb-moonshine:processMash', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('sugar', Config.MoonshineProcessing.Sugar) then
		if Player.Functions.RemoveItem('corn', Config.MoonshineProcessing.Corn) then
			if Player.Functions.AddItem('mash', Config.MoonshineProcessing.Mash) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['sugar'], "remove", Config.MoonshineProcessing.Sugar)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['corn'], "remove", Config.MoonshineProcessing.Corn)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['mash'], "add", Config.MoonshineProcessing.Mash)
				TriggerClientEvent('QBCore:Notify', src, Lang:t("success.coke_small_brick"), "success")
			else
				Player.Functions.AddItem('sugar', Config.MoonshineProcessing.Sugar)
				Player.Functions.AddItem('corn', Config.MoonshineProcessing.Corn)
			end
		else
			Player.Functions.AddItem('sugar', Config.MoonshineProcessing.Sugar)
			TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_bakingsoda"), "error")
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_cokain"), "error")
	end
end)
--bottle into moonshine
RegisterServerEvent('qb-moonshine:processMoonshine', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('mash', Config.MoonshineProcessing.Mash) then
		local amountmoonshine = math.random(8,25)
		if Player.Functions.AddItem('moonshine', Config.MoonshineProcessing.Moonshine) then
			TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['mash'], "remove", Config.MoonshineProcessing.Mash)
			TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['moonshine'], "add", Config.MoonshineProcessing.Moonshine)
			TriggerClientEvent('QBCore:Notify', src, Lang:t("Bottled Done"), "success")
		else
			Player.Functions.AddItem('moonshine', Config.MoonshineProcessing.Moonshine)
		end
	end
end)
--validate items
QBCore.Functions.CreateCallback('qb-moonshine:validate_items', function(source, cb, data)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end

	local hasItems = {
		ret = true,
		items = {}
	}
	for name,amount in pairs(data) do
		local item = Player.Functions.GetItemByName(name)
		if not item or item and item.amount < amount then
			hasItems.ret = false
			hasItems.items[#hasItems.items+1] = QBCore.Shared.Items[name].label
		end
		if not hasItems then break end
	end
	hasItems.item = table.concat(hasItems.items, ", ")
	cb(hasItems)
end)
