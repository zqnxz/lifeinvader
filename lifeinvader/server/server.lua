ESX = nil
 
TriggerEvent(Config.esxPrefix .. ':' .. Config.getSharedObject, function(obj) ESX = obj end)

AddEventHandler('onResourceStart', function(resourceName) 
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
        MySQL.Async.execute('DELETE FROM lifeinvader',{})
end) 
   
ESX.RegisterServerCallback('fetchAds', function(source, cb)  
    local ads = {}

    MySQL.Async.fetchAll('SELECT * FROM `lifeinvader`', {}, function(result)
        for i=1, #result, 1 do
            table.insert(ads, {
                name = result[i].name,
                msg = result[i].msg 
            }) 
        end    
        cb(ads)  
    end) 
end)   
 
RegisterServerEvent('send__anonym')
AddEventHandler('send__anonym', function(txt)
    local plr = ESX.GetPlayerFromId(source)    
 
    if plr.getMoney() >= Config.price then    
        for k,v in pairs(Config_S.blacklistedStrings) do
            if string.find(txt, v) then 
                plr.showNotification(Config.language.blacklistedStringMsg)
                if Config_S.blacklistedStringKick then
                    DropPlayer(source, Config.language.blacklistedStringMsg)
                end   
                return    
            end
        end 
        msg__anonym(txt)
        plr.removeMoney(Config.price)    
        Notify((Config.language.paid):format(Config.price))
        TriggerClientEvent('esx:showAdvancedNotification', -1, Config.language.globalMessageTitle, (Config.language.globalMessageSubtitle):format('Anonym'), txt, "CHAR_LIFEINVADER")
        MySQL.Async.execute('INSERT INTO `lifeinvader` (name, msg) VALUES (@name, @msg)', {   
            ['@name'] = '@Anonym', 
            ['@msg'] = txt
        })      
    else  
        Notify((Config.language.notEnoughMoney):format(Config.price))  
    end 
end)                  
   
RegisterServerEvent('send__normal') 
AddEventHandler('send__normal', function(txt__normal)
    local plr = ESX.GetPlayerFromId(source)

    if plr.getMoney() >= Config.price then  
        for k,v in pairs(Config_S.blacklistedStrings) do
            if string.find(txt__normal, v) then  
                plr.showNotification(Config.language.blacklistedStringMsg)
                if Config_S.blacklistedStringKick then
                    DropPlayer(source, Config.language.blacklistedStringMsg)
                end 
                return    
            end
        end  
        msglog(plr.getName(), txt__normal)
        plr.removeMoney(Config.price)  
        Notify((Config.language.paid):format(Config.price))
        TriggerClientEvent('esx:showAdvancedNotification', -1, Config.language.globalMessageTitle, (Config.language.globalMessageSubtitle):format(plr.getName()), txt__normal, "CHAR_LIFEINVADER") 
        MySQL.Async.execute('INSERT INTO `lifeinvader` (name, msg) VALUES (@name, @msg)', {
            ['@name'] = '@'..string.upper(plr.getName()), 
            ['@msg'] = txt__normal  
        }) 
    else   
        Notify((Config.language.notEnoughMoney):format(Config.price))  
    end
end)       

       
function msglog(source, text) 
    PerformHttpRequest(Config_S.webhook, function(err, text, headers)
        end, 'POST', json.encode({
            embeds = {  
                { 
                    ["description"] = "Schreiber: **" .. source .."**\nNachricht: ``"..text.."``",
                    ["color"] = 16711680,
                    ["author"] = { 
                        ["name"] = "LifeInvader",
                        ["icon_url"] = ""
                    },
                    ["footer"] = {   
                        ["text"] = "Made by qnx",
                    },
                    ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S')
                }
            } 
        }), {
            ['Content-Type'] = 'application/json'
        }
    )  
end

 
function msg__anonym(text) 
    PerformHttpRequest(Config_S.webhook, function(err, text, headers)
        end, 'POST', json.encode({
            embeds = {  
                {  
                    ["description"] = "Schreiber: **Anonym**\nNachricht: ``"..text.."``",
                    ["color"] = 16711680,
                    ["author"] = { 
                        ["name"] = "LifeInvader",
                        ["icon_url"] = ""
                    },
                    ["footer"] = {   
                        ["text"] = "Made by qnx",
                    },
                    ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S')
                }
            } 
        }), {
            ['Content-Type'] = 'application/json'
        }
    )  
end