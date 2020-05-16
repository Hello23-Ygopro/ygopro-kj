--The Swarmleader
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MEGABUG)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_MEGABUG))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--power up
	aux.EnableUpdatePower(c,scard.val1,aux.SelfAttackerCondition)
end
--power up
function scard.val1(e,c)
	return Duel.GetMatchingGroupCount(Card.IsFaceup,c:GetControler(),LOCATION_BZONE,0,c)*2000
end
