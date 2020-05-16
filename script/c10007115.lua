--The Hive Queen
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MEGABUG)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_MEGABUG))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to battle zone
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,aux.DecktopSendtoBZoneOperation(PLAYER_SELF,scard.tbfilter,3,0,1,SEQ_DECK_BOTTOM))
end
--to battle zone
function scard.tbfilter(c)
	return c:IsCreature() and not c:IsEvolution() and c:IsManaCostBelow(5)
end
