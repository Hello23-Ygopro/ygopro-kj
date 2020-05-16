--Warlord Titan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TREE_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--cost down
	aux.EnableUpdatePlayCost(c,-4,aux.ExistingCardCondition(Card.IsFaceup,LOCATION_BZONE,0,3))
end
