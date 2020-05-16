--Mesa Behemoth (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TREE_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_NATURE))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--unleash (search - to hand)
	aux.EnableUnleash(c,0,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
--unleash (search - to hand)
scard.op1=aux.SendtoHandOperation(PLAYER_SELF,Card.IsCreature,LOCATION_DECK,0,0,1,true)
