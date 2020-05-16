--Dauntless Tusker
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TUSKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,4000,aux.ExistingCardCondition(scard.cfilter))
	aux.AddEffectDescription(c,0,aux.ExistingCardCondition(scard.cfilter))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER,aux.ExistingCardCondition(scard.cfilter))
	aux.AddEffectDescription(c,1,aux.ExistingCardCondition(scard.cfilter))
end
--power up, double breaker
function scard.cfilter(c)
	return c:IsFaceup() and c:IsRaceCategory(RACECAT_DRAGON)
end
