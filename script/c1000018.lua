--Dorado, Golden Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CELESTIAL_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--power up
	aux.EnableUpdatePower(c,6000,scard.con1)
	aux.AddEffectDescription(c,0,scard.con1)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER,scard.con1)
	aux.AddEffectDescription(c,1,scard.con1)
end
--triple breaker
function scard.con1(e)
	return Duel.GetShieldCount(e:GetHandlerPlayer())>=5
end
