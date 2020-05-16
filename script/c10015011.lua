--Hydrus the Oathbound
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
	--power up
	aux.EnableUpdatePower(c,scard.val1)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER,scard.con1)
	aux.AddEffectDescription(c,0,scard.con1)
end
--power up
function scard.cfilter(c)
	return c:IsFaceup() and c:IsTapped()
end
function scard.val1(e,c)
	return Duel.GetMatchingGroupCount(scard.cfilter,c:GetControler(),0,LOCATION_BZONE,nil)*3000
end
--triple breaker
function scard.con1(e)
	return e:GetHandler():IsPowerAbove(12000)
end
