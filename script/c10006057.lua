--Issyl of the Frozen Wastes
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TSUNAMI_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--get ability (do not untap)
	aux.EnableEffectCustom(c,EFFECT_DONOT_UNTAP_START_STEP,scard.con1,0,LOCATION_BZONE,scard.tg1)
end
--get ability (do not untap)
scard.con1=aux.SelfTappedCondition
scard.tg1=aux.TargetBoolFunction(Card.IsTapped)
