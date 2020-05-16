--Napalmeon the Conquering
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
	--get ability (powerful attack)
	aux.AddStaticEffectPowerfulAttack(c,5000,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf(Card.KJIsRace,RACE_ARMORED_DRAGON))
	--get ability (break extra shield)
	aux.EnableEffectCustom(c,EFFECT_BREAK_EXTRA_SHIELD,nil,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf(Card.KJIsRace,RACE_ARMORED_DRAGON))
	--get ability (cannot attack)
	aux.EnableEffectCustom(c,EFFECT_CANNOT_ATTACK,nil,0,LOCATION_BZONE,aux.TargetBoolFunction(Card.IsRaceCategory,RACECAT_DRAGON))
end
