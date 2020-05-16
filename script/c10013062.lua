--Baleful Drummer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_EVIL_TOY)
	--creature
	aux.EnableCreatureAttribute(c)
	--discard
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,aux.DiscardOperation(PLAYER_SELF,aux.TRUE,LOCATION_HAND,0,1))
end
