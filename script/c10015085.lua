--Slithering Phantasm
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ROT_WORM,RACE_SPECTER)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter,scard.evofilter)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--unleash (discard)
	aux.EnableUnleash(c,0,aux.CheckCardFunction(aux.TRUE,0,LOCATION_HAND),aux.DiscardOperation(PLAYER_OPPO,aux.TRUE,0,LOCATION_HAND,2))
end
--vortex evolution
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_DARKNESS)
