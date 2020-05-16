--Raptor-Ace Valko
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BURN_BELLY)
	aux.AddNameCategory(c,NAMECAT_VALKO)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,3000,aux.ExistingCardCondition(scard.cfilter))
	aux.AddEffectDescription(c,0,aux.ExistingCardCondition(scard.cfilter))
end
--power up
function scard.cfilter(c)
	return c:IsFaceup() and c:IsCode(CARD_IGNISS)
end
