--Vicious Squillace Scourge
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CORRUPTED,RACE_LEVIATHAN,RACE_CHIMERA)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_CORRUPTED,RACE_LEVIATHAN,RACE_CHIMERA))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--get ability (cannot be blocked)
	aux.AddStaticEffectCannotBeBlocked(c,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.KJIsRace,RACE_CORRUPTED))
	--get ability (slayer)
	aux.AddStaticEffectSlayer(c,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.KJIsRace,RACE_CORRUPTED))
end
