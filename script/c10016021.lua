--Octolith
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_EARTH_EATER)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--cost down
	aux.EnableUpdatePlayCost(c,-4,aux.ExistingCardCondition(aux.KJDPileFilter(Card.IsSpell),LOCATION_DPILE,0,2))
end
