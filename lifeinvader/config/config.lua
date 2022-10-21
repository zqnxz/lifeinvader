Config = {}  

Config.esxPrefix = "esx"
Config.getSharedObject = "getSharedObject"

Config.position = vector3(-1081.9537, -247.8845, 37.7632) 

Config.price = 5000 
  
Config.serverName = 'LIFEINVADER' 
 
Config.language = {
    helpNotify = '~INPUT_PICKUP~ LifeInvader Öffnen',
    noTextProvided = "Du hast keine Nachricht angegeben",
    blacklistedStringMsg = "Deine Nachricht enthält unerlaubte Zeichen", 
    notEnoughMoney = "Du hast nicht genug Geld (%s)",
    paid = "Du bezahlst %s$", 
    messageToLong = "Deine Nachricht ist zu lang (max. %s Zeichen)",
    globalMessageTitle = "Lifeinvader",
    globalMessageSubtitle = "~g~neue Werbung von %s",
}   
  
Config.marker = {      
    type = 21,
    rotate = true,
    enabled = true,   
    drawDistance = 50,
    color = {
        r = 9,
        g = 164,
        b = 241,
        a = 140,
    },
    size = {
        x = 1.0,
        y = 1.0,  
        z = 1.0
    }   
}
 
Config.blip = {
    enabled = true,
    sprite = 77, 
    display = 4,
    scale = 1.0,
    color = 75,
    text = "Lifeinvader" 
}  
 
function Notify(msg) 
    TriggerClientEvent('esx:showNotification', source, msg)
end