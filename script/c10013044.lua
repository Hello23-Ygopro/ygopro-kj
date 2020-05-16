--Ocean Ravager
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_EARTH_EATER)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_WATER))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--unleash (draw)
	aux.EnableUnleash(c,0,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,2))
end
