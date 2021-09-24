ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('ff_peds:GetSteamHex', function(source, cb)
	cb(GetPlayerIdentifiers(source)[1])
end)