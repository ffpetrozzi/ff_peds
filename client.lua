ESX = exports.es_extended:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerLoaded = true
	ESX.PlayerData = xPlayer
end)

RegisterCommand(Config.CommandName, function(source)
	for k, v in pairs(Config.Peds) do
		if ESX.PlayerData.identifier == v.steamhex then
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
		elseif not ESX.PlayerData.identifier == v.steamhex and Config.EnableNoPermsNotification then
			ESX.ShowNotification(Config.Lang["noperms"])
		end
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
