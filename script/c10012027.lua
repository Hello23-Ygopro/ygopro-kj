--Scourge Lord
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SHADOW_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--discard
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,aux.DiscardOperation(PLAYER_OPPO,aux.TRUE,0,LOCATION_HAND,2))
end
