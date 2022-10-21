Config_S = {}

Config_S.blacklistedString = true -- we recommend to keep this true
Config_S.blacklistedStringKick = false
Config_S.blacklistedStrings = { 
    "<", -- Anti XSS Injection
    ">", -- Anti XSS Injection
    -- u can also add blacklisted words under here
}
  
Config_S.webhook = ""  