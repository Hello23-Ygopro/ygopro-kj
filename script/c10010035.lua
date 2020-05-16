--Tusked Shouter
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--protector
	aux.EnableProtector(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--cannot attack player
	aux.EnableEffectCustom(c,EFFECT_CANNOT_ATTACK_PLAYER,aux.ExistingCardCondition(Card.IsFaceup,0,LOCATION_BZONE))
	aux.AddEffectDescription(c,0,aux.ExistingCardCondition(Card.IsFaceup,0,LOCATION_BZONE))
end
