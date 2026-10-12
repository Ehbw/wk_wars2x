--[[---------------------------------------------------------------------------------------

	Wraith ARS 2X
	Created by WolfKnight
	
	For discussions, information on future updates, and more, join 
	my Discord: https://discord.gg/fD4e6WD 
	
	MIT License

	Copyright (c) 2020-2021 WolfKnight

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.

---------------------------------------------------------------------------------------]]--

---@param source string
---@param target number | string
local function canHandleEvent(source, target)
	if not source or not target then
		return false
	end

	if not DoesPlayerExist(target) then
		return false
	end

	local srcPed = GetPlayerPed(source)
	local vehicle = GetVehiclePedIsIn(srcPed, false)
	if vehicle == 0 or not DoesEntityExist(vehicle) then
		return false
	end

	local targetPed = GetPlayerPed(target)
	if vehicle ~= GetVehiclePedIsIn(targetPed, false) then
		return false
	end

	return true
end


--[[----------------------------------------------------------------------------------
	Sync server events
----------------------------------------------------------------------------------]]--
RegisterNetEvent( "wk_wars2x_sync:sendPowerState" )
AddEventHandler( "wk_wars2x_sync:sendPowerState", function( target, state )
	local stateType = type(state)
	if stateType ~= "number" and stateType ~="boolean" then
		return
	end

	if not canHandleEvent(source, target) then
		return
	end

	TriggerClientEvent( "wk_wars2x_sync:receivePowerState", target, state )
end )

RegisterNetEvent( "wk_wars2x_sync:sendAntennaPowerState" )
AddEventHandler( "wk_wars2x_sync:sendAntennaPowerState", function( target, state, ant )
	if not canHandleEvent(source, target) then
		return
	end

	TriggerClientEvent( "wk_wars2x_sync:receiveAntennaPowerState", target, state, ant )
end )

RegisterNetEvent( "wk_wars2x_sync:sendAntennaMode" )
AddEventHandler( "wk_wars2x_sync:sendAntennaMode", function( target, ant, mode )
	if not canHandleEvent(source, target) then
		return
	end

	TriggerClientEvent( "wk_wars2x_sync:receiveAntennaMode", target, ant, mode )
end )

RegisterNetEvent( "wk_wars2x_sync:sendLockAntennaSpeed" )
AddEventHandler( "wk_wars2x_sync:sendLockAntennaSpeed", function( target, ant, data )
	if not canHandleEvent(source, target) then
		return
	end

	TriggerClientEvent( "wk_wars2x_sync:receiveLockAntennaSpeed", target, ant, data )
end )

RegisterNetEvent( "wk_wars2x_sync:sendLockCameraPlate" )
AddEventHandler( "wk_wars2x_sync:sendLockCameraPlate", function( target, cam, data )
	if not canHandleEvent(source, target) then
		return
	end
	TriggerClientEvent( "wk_wars2x_sync:receiveLockCameraPlate", target, cam, data )
end )


--[[----------------------------------------------------------------------------------
	Radar data sync server events
----------------------------------------------------------------------------------]]--
RegisterNetEvent( "wk_wars2x_sync:requestRadarData" )
AddEventHandler( "wk_wars2x_sync:requestRadarData", function( target )
	if not canHandleEvent(source, target) then
		return
	end

	TriggerClientEvent( "wk_wars2x_sync:getRadarDataFromDriver", target, source )
end )

RegisterNetEvent( "wk_wars2x_sync:sendRadarDataForPassenger" )
AddEventHandler( "wk_wars2x_sync:sendRadarDataForPassenger", function( playerFor, data )
	if not canHandleEvent(source, playerFor) then
		return
	end

	TriggerClientEvent( "wk_wars2x_sync:receiveRadarData", playerFor, data )
end )

RegisterNetEvent( "wk_wars2x_sync:sendUpdatedOMData" )
AddEventHandler( "wk_wars2x_sync:sendUpdatedOMData", function( playerFor, data )
	if not canHandleEvent(source, playerFor) then
		return
	end
	TriggerClientEvent( "wk_wars2x_sync:receiveUpdatedOMData", playerFor, data )
end )