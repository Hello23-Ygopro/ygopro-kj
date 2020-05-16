--Sopan, Cyber Renegade
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--confirm shield
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.ConfirmOperation(PLAYER_SELF,aux.ShieldZoneFilter(Card.IsFacedown),LOCATION_SZONE,LOCATION_SZONE,1))
end
