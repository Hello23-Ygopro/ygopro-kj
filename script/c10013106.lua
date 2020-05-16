--Restless Conflagration
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MELT_WARRIOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_FIRE))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--unleash (banish)
	aux.EnableUnleash(c,0,scard.tg1,scard.op1)
end
--unleash (banish)
function scard.banfilter(c)
	return c:IsFaceup() and c:IsHasEffect(EFFECT_BLOCKER) and c:KJIsBanishable()
end
scard.tg1=aux.CheckCardFunction(scard.banfilter,0,LOCATION_BZONE)
scard.op1=aux.BanishOperation(PLAYER_OPPO,scard.banfilter,0,LOCATION_BZONE,1)
