--Pakidamo the Resilient
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STORM_PATROL,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--search (to battle)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.SendtoBZoneOperation(PLAYER_SELF,scard.tbfilter,LOCATION_DECK,0,0,1))
end
--search (to battle)
function scard.tbfilter(c)
	return c:IsCreature() and not c:IsEvolution() and c:IsManaCostBelow(3) and c:IsHasEffect(EFFECT_BLOCKER)
end
