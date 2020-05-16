--Haven's Counsel
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--cost down
	aux.EnableUpdatePlayCost(c,-4,aux.ExistingCardCondition(scard.cfilter,LOCATION_BZONE,0,2))
end
--cost down
function scard.cfilter(c)
	return c:IsFaceup() and c:IsHasEffect(EFFECT_BLOCKER)
end
