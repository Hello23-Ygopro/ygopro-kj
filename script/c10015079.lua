--Megaria's Trapheap
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TARBORG)
	--creature
	aux.EnableCreatureAttribute(c)
	--discard
	aux.AddSingleTriggerEffect(c,0,EVENT_BANISHED,nil,nil,aux.DiscardOperation(PLAYER_OPPO,aux.TRUE,0,LOCATION_HAND,1))
end
