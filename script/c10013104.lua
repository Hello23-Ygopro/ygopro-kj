--Rally Bot
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STOMPER)
	--creature
	aux.EnableCreatureAttribute(c)
	--fast attack
	aux.EnableEffectCustom(c,EFFECT_FAST_ATTACK,aux.ExistingCardCondition(scard.cfilter))
	aux.AddEffectDescription(c,0,aux.ExistingCardCondition(scard.cfilter))
end
--fast attack
function scard.cfilter(c)
	return c:IsFaceup() and c:IsEvolution()
end
