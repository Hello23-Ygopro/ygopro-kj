--Halon, Paragon of Light
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ENFORCER)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_ENFORCER))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
