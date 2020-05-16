--Charging Greatclaw
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TUSKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_NATURE))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--unleash (to mana zone)
	aux.EnableUnleash(c,0,aux.DecktopSendtoMZoneTarget(PLAYER_SELF),aux.DecktopSendtoMZoneOperation(PLAYER_SELF,1))
end
