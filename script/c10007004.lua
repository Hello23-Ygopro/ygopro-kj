--Citadel Steward
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_FRACTAL)
	--creature
	aux.EnableCreatureAttribute(c)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_BANISHED,nil,nil,aux.SendtoHandOperation(PLAYER_SELF,aux.KJDPileFilter(Card.IsSpell),LOCATION_DPILE,0,1))
end
