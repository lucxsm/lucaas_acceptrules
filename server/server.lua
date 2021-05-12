-- Register Events Server
ESX = nil
local spielerID = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

end)

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end

	print('FIVEREALLIFE: ' .. resourceName .. ' has been started.')


  end)

  RegisterCommand("regelwerk", function(source, args, rawCommand)

	TriggerEvent("lucaas_acceptrules:checkIfRule", source)

end)
    

Citizen.CreateThread(function()
	local source = source
	TriggerEvent("lucaas_acceptrules:checkIfRule", source)
end)

RegisterNetEvent('lucaas_acceptrules:checkIfRule')
AddEventHandler('lucaas_acceptrules:checkIfRule', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)
	--local identifier = GetPlayerIdentifiers(source)[0]

	local identifier

	for k,v in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(v, 'license:') then
			identifier = string.sub(v, 9)
			break
		end
	end
	print(identifier)

	MySQL.Async.fetchAll('SELECT rulesaccepted FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
	}, function(result)
		print(result)
		if result[1] ~= nil then
			if result[1].rulesaccepted == 0 then
				print('notaccepted')
				TriggerClientEvent("lucaas_acceptrules:openRules", source)
			else
				TriggerClientEvent("lucaas_acceptrules:closeRules", source)
			end
		end
	end)

end)


ESX.RegisterServerCallback('lucaas_acceptrules:acceptrules', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)
	--local identifier = GetPlayerIdentifiers(source)[0]

	local identifier

	for k,v in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(v, 'license:') then
			identifier = string.sub(v, 9)
			break
		end
	end

	MySQL.Async.execute('UPDATE users SET rulesaccepted = 1 WHERE identifier = @identifier', {
		['@identifier']        = identifier
		}, function(rowsChanged)
			TriggerClientEvent('esx:showNotification', source, "Du hast die Regeln akzeptiert.")
			cb('ok')
		end)

end)


