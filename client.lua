ESX = nil

local breakMessages = {
	"Oh nee, je laat je aansteker vallen!",
	"Wat doe je nu? Heel dat ding kapot!",
	"Wat een pech, aansteker weg!",
	"Het gas in je aansteker is op!",
	"Wat een kracht, je sloopt heel je aansteker!"
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

math.randomseed( GetGameTimer() )

function shouldLighterBreak()
	return math.random(1,100) <= 10;
end

function breakLighter()
	TriggerServerEvent("cagelighter:breakLighter")
	ESX.ShowNotification( ("~r~%s"):format( breakMessages[ math.random(1, #breakMessages) ] ) )
end

RegisterNetEvent("cagelighter:spark")
AddEventHandler("cagelighter:spark", function()

  SendNUIMessage({
    event = 'lighter'
  })

  Citizen.CreateThread(function()
    local fireInts = {}

    local ped = PlayerPedId()
    local fireAmount = 4

    for i = 1, fireAmount, 1 do

      local fireCoords            = GetOffsetFromEntityInWorldCoords( ped, 0.0,  tonumber( ( (i*0.5)+ 0.5) ), 0 )
      local groundSucces, groundZ = GetGroundZFor_3dCoord(fireCoords.x, fireCoords.y, fireCoords.z, 0)
      table.insert( fireInts, StartScriptFire(fireCoords.x, fireCoords.y, groundZ, 10, false) )

      if i == 2 or i == 3 then

        local fireCoords            = GetOffsetFromEntityInWorldCoords( ped, -0.5,  tonumber( ( (i*0.5)+ 0.5) ), 0 )
        local groundSucces, groundZ = GetGroundZFor_3dCoord(fireCoords.x, fireCoords.y, fireCoords.z, 0)
        table.insert( fireInts, StartScriptFire(fireCoords.x, fireCoords.y, groundZ, 10, false) )

        local fireCoords            = GetOffsetFromEntityInWorldCoords( ped, 0.5,  tonumber( ( (i*0.5)+ 0.5) ), 0 )
        local groundSucces, groundZ = GetGroundZFor_3dCoord(fireCoords.x, fireCoords.y, fireCoords.z, 0)
        table.insert( fireInts, StartScriptFire(fireCoords.x, fireCoords.y, groundZ, 10, false) )

      end

    end

    Citizen.Wait(500)

    for i = 1, #fireInts, 1 do
        RemoveScriptFire(fireInts[i])
    end

  end)

	if shouldLighterBreak() then
		breakLighter()
	end

end)
