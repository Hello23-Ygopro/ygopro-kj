--Hammer Dragon Foulbyrn
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--confirm deck (to battle)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,aux.DecktopSendtoBZoneOperation(PLAYER_SELF,scard.tbfilter,1,nil,nil,SEQ_DECK_BOTTOM,true))
end
--confirm deck (to battle)
function scard.tbfilter(c)
	return not c:IsEvolution() and c:IsRaceCategory(RACECAT_DRAGON)
end
