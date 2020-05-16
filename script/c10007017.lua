--Aqua-Ranger Commander
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_AQUAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_AQUAN))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--cannot be blocked
	aux.EnableCannotBeBlocked(c)
end
