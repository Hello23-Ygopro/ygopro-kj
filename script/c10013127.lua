--Bronze-Arm Gladiator
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_NATURE))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--power up
	aux.EnableUpdatePower(c,4000,aux.TurnPlayerCondition(PLAYER_OPPO))
	aux.AddEffectDescription(c,0,aux.TurnPlayerCondition(PLAYER_OPPO))
end
