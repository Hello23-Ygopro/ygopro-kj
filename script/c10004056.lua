--Orion, Radiant Fury
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CELESTIAL_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--tap
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--to battle zone
	aux.AddSingleTriggerEffect(c,1,EVENT_BANISHED,nil,nil,aux.DecktopSendtoBZoneOperation(PLAYER_SELF,scard.tbfilter,3,0,MAX_NUMBER,SEQ_DECK_BOTTOM))
end
--tap
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToTap()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.posfilter,0,LOCATION_BZONE,0,3,HINTMSG_TAP)
scard.op1=aux.TargetCardsOperation(Duel.Tap,REASON_EFFECT)
--to battle zone
function scard.tbfilter(c)
	return c:IsCreature() and not c:IsEvolution() and c:IsCivilization(CIVILIZATION_LIGHT)
end
