--General Charzon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CORRUPTED,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_CORRUPTED,RACE_ARMORED_DRAGON))
	--get ability (powerful attack)
	aux.AddStaticEffectPowerfulAttack(c,5000,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.KJIsRace,RACE_CORRUPTED))
	--get ability (double breaker)
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER,nil,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.KJIsRace,RACE_CORRUPTED))
end
