--Perseus Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CELESTIAL_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--power up
	aux.EnableUpdatePower(c,2000,scard.con1)
	aux.AddEffectDescription(c,0,scard.con1)
	--blocker
	aux.EnableBlocker(c,scard.con1)
	aux.AddEffectDescription(c,1,scard.con1)
end
--power up, blocker
function scard.con1(e)
	return Duel.GetShieldCount(e:GetHandlerPlayer())<=2
end
