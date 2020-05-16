--Oblivion Knight
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SHADOW_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_DARKNESS))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--unleash (discard)
	aux.EnableUnleash(c,0,aux.CheckCardFunction(aux.TRUE,0,LOCATION_HAND),scard.op1)
end
--unleash (discard)
scard.op1=aux.DiscardOperation(PLAYER_OPPO,aux.TRUE,0,LOCATION_HAND,2)
