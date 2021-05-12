
ESX                           = nil
local guiEnabled = false

Citizen.CreateThread(function ()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    
  end
end)


function EnableGui(enable)
    SetNuiFocus(enable, enable)
    guiEnabled = enable

    SendNUIMessage({
        enablegui = true
    })
end


--Citizen.CreateThread(function()      
        --print('rules')
        --TriggerServerEvent('lucaas_acceptrules:checkIfRule', GetPlayerServerId(PlayerId()))
--end) 


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    print('rules')
    TriggerServerEvent('lucaas_acceptrules:checkIfRule', GetPlayerServerId(PlayerId()))
end) 

--RegisterNUICallback('UCP_LOGIN_NEU:gettoken', function(data, cb)
--    EnableGui()
--end)

RegisterNetEvent('lucaas_acceptrules:openRules')
AddEventHandler('lucaas_acceptrules:openRules', function(source)


    SetNuiFocus(true, true)
    EnableGui(true)
    print('ok')
end)

RegisterNetEvent('lucaas_acceptrules:closeRules')
AddEventHandler('lucaas_acceptrules:closeRules', function(source)


    SetNuiFocus(false, false)
    EnableGui(false)
    SendNUIMessage({
        enablegui = false
    })
    print('ok')
end)

RegisterNUICallback('login', function(data, cb)
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end)

RegisterNUICallback('acceptrules', function(data, cb)
    print('ok')
    ESX.TriggerServerCallback('lucaas_acceptrules:acceptrules', function (isOkay)
        print(isOkay)

        if isOkay == 'ok' then
            SetNuiFocus(false, false)
            EnableGui(false)
            SendNUIMessage({
                enablegui = false
            })
        end
    end)
end)

RegisterNUICallback('escape', function(data, cb)
    SetNuiFocus(false, false)
    EnableGui(false)
    SendNUIMessage({
        enablegui = false
    })
    cb('ok')
end)


