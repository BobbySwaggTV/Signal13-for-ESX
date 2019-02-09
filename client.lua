local PlayerData                = {}
local GUI                       = {}
local holstered 								= true
ESX                             = nil
GUI.Time                        = 0


function getJob()
  if PlayerData.job ~= nil then
  return PlayerData.job.name
  end
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

---------------------------------------------------------------------------
-- ESX BS ABOVE Used to make sure the police job is the only one that is getting or sending these alerts
---------------------------------------------------------------------------

---------------------------------------------------------------------------
-- pnotify
---------------------------------------------------------------------------

function sendNotification(message, messageType, messageTimeout)
	TriggerEvent("pNotify:SendNotification", {
		text = message,
		type = messageType,
		queue = "sig13",
		timeout = messageTimeout,
		layout = "bottomCenter"
	})
end

---------------------------------------------------------------------------
-- skrubs signal 13 
---------------------------------------------------------------------------
RegisterNetEvent('s13')
AddEventHandler('s13', function()

  if PlayerData.job.name == 'police' then -- checks the job
    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
    local streetName, crossing = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
    local streetName, crossing = GetStreetNameAtCoord(x, y, z)
    streetName = GetStreetNameFromHashKey(streetName)
    crossing = GetStreetNameFromHashKey(crossing)
    sendNotification(('SIGNAL 13 ACTIVTED AND TRANSMITTING'), 'success', 10000) -- send a notification using Pnotify please have Pnotify in your resources and running

      local coords      = GetEntityCoords(GetPlayerPed(-1))

      TriggerServerEvent('esx_phone:send', "police", "SIGNAL 13 ACTIVATED!  OFFICER IN DISTRESS. ALL UNITS RESPOND CODE 3. " .. streetName, true, {
        x = coords.x,
        y = coords.y,
        z = coords.z
			})
			TriggerServerEvent('esx_phone:send', "ambulance", "SIGNAL 13 ACTIVATED BY A POLICE OFFICER IN DISTRESS AND MAY REQUIRE MEDICAL ATTENTION! " .. streetName, true, {
        x = coords.x,
        y = coords.y,
        z = coords.z
      })
    end
end)