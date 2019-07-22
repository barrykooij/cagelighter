-- ESX
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
  ESX = obj

  ESX.RegisterUsableItem('cagelighter', function(source)
    TriggerClientEvent("cagelighter:spark", source)
  end)
end)

RegisterNetEvent("cagelighter:breakLighter")
AddEventHandler("cagelighter:breakLighter", function()
  local xPlayer = ESX.GetPlayerFromId(source)

  if xPlayer ~= nil then
    xPlayer.removeInventoryItem("cagelighter", 1)
  end
end)
