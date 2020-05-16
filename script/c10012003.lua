--Caelum Skysworn
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CELESTIAL_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--cannot attack player
	aux.EnableEffectCustom(c,EFFECT_CANNOT_ATTACK_PLAYER,aux.ExistingCardCondition(scard.cfilter,0,LOCATION_BZONE))
	aux.AddEffectDescription(c,0,aux.ExistingCardCondition(scard.cfilter,0,LOCATION_BZONE))
end
--cannot attack player
function scard.cfilter(c)
	return c:IsFaceup() and c:IsTapped()
end
