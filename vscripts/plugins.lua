require('includes/timers')
-- require('includes/json')

print 	('###############')
print 	('Plugins Loaded')
print	('Author: Palonez')
print	('Version: 0.5')
print 	('###############')

local vkontakte, telegram, discord, c4t
local totalAds = 0
local currentAd = 1
local names = {}
local networkids = {}
local steamids = {}

local kv = LoadKeyValues("scripts/configs/plugins.ini")
-- local bans = LoadKeyValues("scripts/configs/bans.ini")

function intToIp(int)
	local a = bit.band(int, 0xFF000000)
	local b = bit.band(int, 0x00FF0000)
	local c = bit.band(int, 0x0000FF00)
	local d = bit.band(int, 0x000000FF)

	a = bit.rshift(a, 24)
	b = bit.rshift(b, 16)
	c = bit.rshift(c, 8)

	local ip = a .. "." .. b .. "." .. c .. "." .. d
	return ip
end

function ReplaceTags(str)
	str = string.gsub(str, "{WHITE}", "\x01")
	str = string.gsub(str, "{DARKRED}", "\x02")
	str = string.gsub(str, "{PURPLE}", "\x03")
	str = string.gsub(str, "{DARKGREEN}", "\x04")
	str = string.gsub(str, "{LIGHTGREEN}", "\x05")
	str = string.gsub(str, "{GREEN}", "\x06")
	str = string.gsub(str, "{RED}", "\x07")
	str = string.gsub(str, "{LIGHTGREY}", "\x08")
	str = string.gsub(str, "{YELLOW}", "\x09")
	str = string.gsub(str, "{ORANGE}", "\x10")
	str = string.gsub(str, "{DARKGREY}", "\x0A")
	str = string.gsub(str, "{BLUE}", "\x0B")
	str = string.gsub(str, "{DARKBLUE}", "\x0C")
	str = string.gsub(str, "{GRAY}", "\x0D")
	str = string.gsub(str, "{DARKPURPLE}", "\x0E")
	str = string.gsub(str, "{LIGHTRED}", "\x0F")
	str = string.gsub(str, "{NL}", "\xe2\x80\xa9")
	str = string.gsub(str, "{PORT}", tostring(Convars:GetInt("hostport")))
	str = string.gsub(str, "{IP}", intToIp(Convars:GetInt("hostip")))
	str = string.gsub(str, "{MAXPL}", tostring(Convars:GetInt("sv_visiblemaxplayers")))
	str = string.gsub(str, "{PL}", tostring(#Entities:FindAllByClassname("player")))
	str = string.gsub(str, "{MAP}", GetMapName())
	local nextmap
	if Convars:GetStr("nextlevel") == "" then
		nextmap = "unknown"
	else
		nextmap = Convars:GetStr("nextlevel")
	end
	str = string.gsub(str, "{NEXTMAP}", nextmap)
	str = string.gsub(str, "{TIME}", Time())
	str = string.gsub(str, "{DISCORD}", discord)
	str = string.gsub(str, "{VK}", vkontakte)
	str = string.gsub(str, "{TG}", telegram)
	return str
end

function PrintToAll(str, outType)
	if outType == "chat" then
		ScriptPrintMessageChatAll(ReplaceTags(str))
	elseif outType == "center" then
		ScriptPrintMessageCenterAll(ReplaceTags(str))
	end	
end

function loadCFG()
	if kv ~= nil then
		vkontakte = kv["vk"]
		telegram = kv["telegram"]
		discord = kv["discord"]
		timeAds = kv["time"]
		
		for k, v in pairs(kv["adverts"]) do
			totalAds = totalAds + 1
		end
		
		print("plugins.ini loaded")
		
		if totalAds == 0 then
			return false
		end
		
		if timeAds == 0.0 then
			return false
		end
		
		return true
	else 
		print("Couldn't load config file scripts/configs/plugins.ini")
		return false
	end
end

function PlayerDeath(event)
	local attacker, user
	
	for k, v in pairs(names) do
		if k == event["attacker"] then
			attacker = v
		elseif k == event["userid"] then
			user = v
		end
	end
	
	if attacker ~= nil and user ~= nil then
		if attacker ~= user then
			if event["distance"] ~= nil then 
				if kv["kill_announce"] == 1 then
					local message = kv["kill_announce_message"]
					message = string.gsub(message, "{attacker}", attacker)
					message = string.gsub(message, "{user}", user)
					message = string.gsub(message, "{distance}", tonumber(string.format("%.2f", event["distance"])))
					PrintToAll(message, "chat")
				end
			end
		end
	end
end

function PlayerConnect(event)
	if #Entities:FindAllByClassname("player") > 1 then
		if event["bot"] == false then
			steamids[event["userid"]] = SteamID3toSteamID2(event["networkid"])
		end
	end
	networkids[event["userid"]] = event["networkid"]
	names[event["userid"]] = event["name"]
	
	if kv["connect_announce"] == 1 then
		local bot
		if event["bot"] == true then 
			bot = ""
		else
			bot = "(bot)" 
		end
		local message = kv["connect_announce_message"]
		message = string.gsub(message, "{user}", event["name"])
		message = string.gsub(message, "{botstatus}", bot)
		message = string.gsub(message, "{steamid}", "")
		if steamids[event["userid"]] ~= nil then
			-- if event["bot"] == true then
				-- message = string.gsub(message, "{steamid}", "")
			-- else
				message = string.gsub(message, "{steamid}", steamids[event["userid"]])
			-- end
		end
		PrintToAll(message, "chat")
	end
end

-- Convars:RegisterCommand('ban', BanPlayer, '', 0)

-- function BanPlayer(userid, bantime, reason)
	-- io.open("scripts/configs/bans.ini", 'a+')
	-- local id = SteamID3toSteamID2(networkids[userid])
	-- local jsn_table = {
		-- id = 
		-- {
			-- ["name"] = names[userid],
			-- ["time"] = bantime,
			-- ["expired"] = tonumber(os.time(os.date("!*t")))+bantime,
			-- ["reason"] = reason
		-- }
	-- }
	-- print(hi)
	-- print(json_encode(jsn_table))
	-- io.write(json_encode(jsn_table))
	-- io.close()
-- end

function SteamID3toSteamID2(networkid)
	networkid = string.sub(networkid, 6)
	networkid = string.gsub(networkid, "]", "")
	return "STEAM_0:" .. bit.band(tonumber(networkid), 1) .. ":" .. bit.rshift(tonumber(networkid), 1)
end

function PlayerDisconnect(event)
	if kv["disconnect_announce"] == 1 then
		local bot
		if event["bot"] == true then 
			bot = ""
		else
			bot = "(bot)" 
		end
		local message = kv["disconnect_announce_message"]
		message = string.gsub(message, "{user}", event["name"])
		message = string.gsub(message, "{botstatus}", bot)
		PrintToAll(message, "chat")
	end
	steamids[event["userid"]] = nil
	networkids[event["userid"]] = nil
	names[event["userid"]] = nil
end

function PlayerTeam(event)
	if kv["change_team_announce"] == 1 then
		if event["disconnect"] ~= true then
			if event["isbot"] ~= true then
				local player = GetNameByID(event["userid"])
				if player ~= nil then
					if event["team"] ~= nil then
						local team
						if event["team"] == 0 then
							team = "unconnected"
						elseif event["team"] == 1 then
							team = "spec"
						elseif event["team"] == 2 then
							team = "T"
						elseif event["team"] == 3 then
							team = "CT"
						end

						local message = kv["change_team_announce_message"]
						message = string.gsub(message, "{user}", player)
						message = string.gsub(message, "{team}", team)
						PrintToAll(message, "chat")
					end
				end
			end
		end
	end
end

function GetNameByID(id)
	for k, v in pairs(names) do
		if k == id then
			return v
		else 
			return nil
		end
	end
end

function RoundEnd(event)
	if kv["round_end_message_status"] == 1 then
		if kv["round_end_message"].Chat ~= nil then
			PrintToAll(kv["round_end_message"].Chat, "chat")
		end
		
		if kv["round_end_message"].Center ~= nil then
			PrintToAll(kv["round_end_message"].Center, "center")
		end
	end
	
	if c4t ~= nil then	
		Timers:RemoveTimer(c4t)
	end
end

function RoundStart(event)
	if kv["round_start_message_status"] == 1 then
		if kv["round_start_message"].Chat ~= nil then
			PrintToAll(kv["round_start_message"].Chat, "chat")
		end
		
		if kv["round_start_message"].Center ~= nil then
			PrintToAll(kv["round_start_message"].Center, "center")
		end
	end
end

function BombPlanted(event)
	if kv["bomb_time_announce"] == 1 then
		local bombBackCounter = Convars:GetInt("mp_c4timer")
		c4t = Timers:CreateTimer(1, function()
			if bombBackCounter > 0 then
				bombBackCounter = bombBackCounter - 1
			elseif c4t ~= nil then	
				Timers:RemoveTimer(c4t)
			end
			
			if bombBackCounter == 20 or bombBackCounter == 10 then
				PrintToAll("Before the explosion is left: " .. bombBackCounter .. " seconds", "center")
			end
			
			if bombBackCounter <= 5 then
				PrintToAll(bombBackCounter .. "...", "center")
			end
			
			if bombBackCounter ~= 0 then
				return 1.0
			end
			end
		)
	end
end

if loadCFG() then
	Timers:CreateTimer(function()
	
		local counter = currentAd
		if kv["adverts"][tostring(counter)].Chat ~= nil then
			PrintToAll(kv["adverts"][tostring(counter)].Chat, "chat")
		end

		if kv["adverts"][tostring(counter)].Center ~= nil then
			PrintToAll(kv["adverts"][tostring(counter)].Center, "center")
		end
		
		currentAd = currentAd + 1
		
		if currentAd > totalAds then 
			currentAd = 1
		end 
		
		return timeAds
		end
	)
end

ListenToGameEvent("player_connect", PlayerConnect, self)
ListenToGameEvent("player_disconnect", PlayerDisconnect, self)
ListenToGameEvent("player_death", PlayerDeath, self)
ListenToGameEvent("round_start", RoundStart, self)
ListenToGameEvent("round_end", RoundEnd, self)
ListenToGameEvent("player_team", PlayerTeam, self)
ListenToGameEvent("bomb_planted", BombPlanted, self)