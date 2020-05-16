--Volcano Dervish
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION,RACE_MELT_WARRIOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_SKYFORCE_CHAMPION,RACE_MELT_WARRIOR))
	--protector
	aux.EnableProtector(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--untap
	aux.EnableTurnEndSelfUntap(c)
end
