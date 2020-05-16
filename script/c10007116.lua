--Truthseeker Forion
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION,RACE_CYBER_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--cast for free
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
end
--cast for free
function scard.castfilter(c)
	return c:IsSpell() and c:IsHasEffect(EFFECT_SHIELD_BLAST)
end
scard.tg1=aux.CheckCardFunction(scard.castfilter,LOCATION_HAND,0)
scard.op1=aux.CastOperation(PLAYER_SELF,scard.castfilter,LOCATION_HAND,0,1)
