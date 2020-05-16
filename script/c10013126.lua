--Barbed Crusher
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MEGABUG)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_NATURE))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
