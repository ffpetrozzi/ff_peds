ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterCommand(Config.CommandName, function(source)
	for k, v in pairs(Config.Peds) do
		ESX.TriggerServerCallback('ff_peds:GetSteamHex', function(steamhexplayer)
			if steamhexplayer == v.steamhex then
				if not v.pedmenu then
					SetPed(v.ped)
				elseif v.pedmenu then
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'chooseped', {
						title = Config.Lang["chooseaped"]
					}, function(data, menu)
						menu.close()
						SetPed(data.value)
					end, function(data, menu)
						menu.close()
					end)
				end
			elseif not steamhexplayer == v.steamhex and Config.EnableNoPermsNotification then
				ESX.ShowNotification(Config.Lang["noperms"])
			end
		end)
	end
end, false)

SetPed = function(ped)
	local hash = ped
	local model = GetHashKey(hash)

	RequestModel(model)
	while not HasModelLoaded(model) do
		RequestModel(model)
		Citizen.Wait(0)
	end

	SetPlayerModel(PlayerId(), model)
	SetModelAsNoLongerNeeded(model)
	SetPedDefaultComponentVariation(PlayerPedId())
end