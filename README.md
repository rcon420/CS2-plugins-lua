# CS2-plugins-lua

**IMPORTANT: Only for folder OTHER: Since when the map is changed, the player_connect event is not executed, in which all important data is transmitted, it was decided to kick all players at those moments when the map is changed so that they manually perform this event. Without it, the plugin is really useless and will not work.**

Includes 9 mini lua plugins for CS2

- Mini-admin
- Voting for map
- Ammo and health refill after kill
- Connect/disconnect events announcer
- Team switch announcer
- Advertisement
- Kill announcer with distance print
- Round end/start announcer
- Bomb explode announcer

https://github.com/Quake1011/CS2-plugins-lua/assets/58555031/50b5fdc8-c219-4b69-9a0d-c0cf7e02ea92
![image](https://github.com/Quake1011/CS2-plugins-lua/assets/58555031/7a1a3172-cbd2-46dd-8b57-a84f0e47f457)
![image](https://github.com/Quake1011/CS2-plugins-lua/assets/58555031/9d107fa1-e816-43ba-8cb6-fd1f5d323fa3)
![1696519118102](https://github.com/Quake1011/CS2-plugins-lua/assets/58555031/b8828d36-0c12-4194-969a-642f20feb42c)
![1696462889660](https://github.com/Quake1011/CS2-plugins-lua/assets/58555031/d577bdcf-8061-438d-b99a-36e2fb518a63)
![1696442132297](https://github.com/Quake1011/CS2-plugins-lua/assets/58555031/c9c87e28-922b-4b4d-8d0c-03767a1556a3)
![1696442460163](https://github.com/Quake1011/CS2-plugins-lua/assets/58555031/1b648968-de98-453f-8848-7c514f71a266)
![1696442440011](https://github.com/Quake1011/CS2-plugins-lua/assets/58555031/a64fc621-9969-4fab-bf96-d1c6e2b0fff5)
![273487569-64fafb2d-45d1-49ae-bec1-0b1a80cef984](https://github.com/Quake1011/CS2-plugins-lua/assets/58555031/eda2567b-42f2-4a3e-b9b9-51c67ce18f0f)


## Install
1) Place contains of folder(s) in **game\csgo\scripts**. If **scripts** folder not exist then you should to make it
2) Add to **gamemode_your_gamemode_name.cfg** next lines:
> You can load all script or 1 one them if u want
```
sv_cheats 1
script_reload_code your_script_name.lua
sv_cheats 0
```

```
sv_cheats 1
script_reload_code your_script_name.lua
script_reload_code your_script_name.lua
script_reload_code your_script_name.lua
sv_cheats 0
```
3) Reload the server


## Requirements
- patching vscript.dll:
	- [method-1](https://hlmod.net/threads/source-2-skripting.64842/post-631602)
	- [method-2](https://github.com/Source2ZE/LuaUnlocker)
 	- [method-3](https://github.com/bklol/vscriptPatch/tree/main)
 	- [method-4](https://hlmod.net/threads/source-2-skripting.64842/page-6#post-631991)(easilier)

## Commands(Other)
For admin:
- **kickit \<uid\> <reason>** - kick player from server
- **setmap \<map\> <changetime>** - change the map after the specified time interval in seconds
- **conexec \<convar\> <newvalue>** - change the value of the server variable
- **asay \<message\>** - write a message from the admin to the chat (all characters up to 127 ascii encoding)
- **hp <uid> \<value\>** - set the number of hp to the player
- **size <uid> \<value\>** - set the player size (any decimal positive number, for example 0.5 or 49.0)
- **clr \<uid\> \<r\> \<g\> \<b\> \<a\>** - set color and transparency to the player (all RGBA numbers within 0 - 255)
- **grav \<uid\> \<value\>** - set gravity to the player (any decimal positive number, for example 0.5 or 49.0)
- **fric \<uid\> \<value\>** - to set the grip on the surface of the player (any decimal positive number, for example 0.5 or 49.0)
- **disarm \<uid\>** \<weapon_classname\> - remove the player's weapon, for example, weapon_ak47. Delete all weapons - instead of <weapon_classname> write - @all
- **killit \<uid\>** - kill the player
- **changeteam \<uid\> \<team\>** - change the player's team (team number or short name. For example ct or 3)
- **hudstatus \<uid\> \<status\>** - turn off or turn off the hood to the player (0 or 1)
  
For all:
- **login \<password\>** - getting administrator rights for a session
- **votemap \<mapname\>** - vote for the card
- **suicide** - kill yourself

## Credits
https://github.com/deaFPS
https://vk.com/prodby4realraze(testing)

## About possible problems, please let me know: 
- discord - quake1011
All icons below are clickabled

[<img src="https://i.ibb.co/LJz83MH/a681b18dd681f38e599286a07a92225d.png" width="15.3%"/>](https://discordapp.com/users/858709381088935976/)
[<img src="https://i.ibb.co/tJTTmxP/vk-process-mining.png" width="15.3%"/>](https://vk.com/bgtroll)
[<img src="https://i.ibb.co/VjhryGb/png-transparent-brand-logo-steam-gump-s.png" width="15.3%"/>](https://hlmod.ru/members/palonez.92448/)
[<img src="https://i.ibb.co/xHZPN0g/s-l500.png" width="15.3%"/>](https://steamcommunity.com/id/comecamecame)
[<img src="https://i.ibb.co/S0LyzmX/tg-process-mining.png" width="16.3%"/>](https://t.me/ArrayListX)
[<img src="https://i.ibb.co/Tb2gprD/2056021.png" width="15.3%"/>](https://github.com/Quake1011)
