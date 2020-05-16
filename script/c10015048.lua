--Runemaster Zyr
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TSUNAMI_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--cast for free
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1)
end
--cast for free
function scard.castfilter(c)
	return c:IsSpell() and c:IsManaCostBelow(9)
end
scard.tg1=aux.CheckCardFunction(scard.castfilter,LOCATION_HAND,0)
scard.op1=aux.CastOperation(PLAYER_SELF,scard.castfilter,LOCATION_HAND,0,1)
