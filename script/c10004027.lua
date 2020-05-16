--Locomotivator
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TARBORG)
	--creature
	aux.EnableCreatureAttribute(c)
	--to hand
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.SendtoHandOperation(PLAYER_SELF,aux.ShieldZoneFilter(),LOCATION_SZONE,0,1))
end
