--ESX Boilerplate
 
ESX = nil
local PlayerData = {}
 
Citizen.CreateThread(function()  
    while ESX == nil do
        TriggerEvent(Config.esxPrefix .. ':' .. Config.getSharedObject, function(obj) ESX = obj end)
        Citizen.Wait(0) 
    end 
 
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)  
    end
 
    ESX.PlayerData = ESX.GetPlayerData();
end)
  
--Register Net Events 
RegisterNetEvent(Config.esxPrefix .. ':playerLoaded')
AddEventHandler(Config.esxPrefix .. ':playerLoaded', function(xPlayer)
    PlayerData = xPlayer  
end)
  
RegisterNetEvent(Config.esxPrefix .. ':setJob')
AddEventHandler(Config.esxPrefix .. ':setJob', function(job)
        PlayerData.job = job 
end) 
 

-- marker  
Citizen.CreateThread(function() 
    while true do 
        Citizen.Wait(1)  
        if Config.marker.enabled then 
            local sleep = true  
            local pedcoords = GetEntityCoords(PlayerPedId())
            local dist = #(pedcoords - vector3(Config.position))

            if dist <= Config.marker.drawDistance / 2 then  
                sleep = false 
            end    
  
            if dist < Config.marker.drawDistance then     
                DrawMarker(Config.marker.type, Config.position, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.marker.size.x, Config.marker.size.y, Config.marker.size.z, Config.marker.color.r, Config.marker.color.g, Config.marker.color.b, Config.marker.color.a, false, false, 2, Config.marker.rotate, nil, nil, false)
            end

            if sleep then
                Citizen.Wait(1000)  
            end  
      
            if dist < 2 then 
                ESX.ShowHelpNotification(Config.language.helpNotify)
                if IsControlJustReleased(1, 38) then
                    DisplayRadar(false) 
                    SetNuiFocus(true, true)   
                    SendNUIMessage({ 
                        action = 'InSideMenu',   
                        status = true,
                        servername = Config.serverName,
                    })     

                    ESX.TriggerServerCallback('fetchAds', function(cb) 
                        for k,v in pairs(cb) do 
                            SendNUIMessage({
                                action = 'add',
                                name = v.name,
                                msg = v.msg
                            })  
                        end
                    end)      
                end   
            end 
        end     
    end
end)  

RegisterNUICallback('anonym', function(data) 
    TriggerServerEvent('send__anonym', data.text)    
end)
 
RegisterNUICallback('normal', function(data)
    TriggerServerEvent('send__normal', data.text)
end)

RegisterNUICallback('Message__Error', function() 
    ESX.ShowNotification(Config.language.noTextProvided)
end)

RegisterNUICallback('checked__error', function()
    ESX.ShowNotification('Du darfst maximals 1. sache Auswählen')
end)

-- blips   
Citizen.CreateThread(function()
    if Config.blip.enabled then
        local blip = AddBlipForCoord(vector3(Config.position)) 
        SetBlipSprite(blip, Config.blip.sprite) 
        SetBlipScale(blip, Config.blip.scale)  
        SetBlipColour(blip, Config.blip.color)
        SetBlipDisplay(blip, Config.blip.display)  
        SetBlipAsShortRange(blip, true)   
        BeginTextCommandSetBlipName("STRING")  
        AddTextComponentString(Config.blip.text)
        EndTextCommandSetBlipName(blip)  
    end
end)

-- close
RegisterNUICallback("close", function(data) 
	SetNuiFocus(false, false)
	DisplayRadar(true)
	TriggerScreenblurFadeOut(0)
end)