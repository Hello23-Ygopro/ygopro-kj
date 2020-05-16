--Woolly Tusker
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TUSKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,2000,aux.ExistingCardCondition(scard.cfilter))
	aux.AddEffectDescription(c,0,aux.ExistingCardCondition(scard.cfilter))
	--cannot be blocked
	aux.EnableCannotBeBlocked(c,aux.CannotBeBlockedLessPowerValue,aux.ExistingCardCondition(scard.cfilter))
	aux.AddEffectDescription(c,1,aux.ExistingCardCondition(scard.cfilter))
end
--power up, cannot be blocked
function scard.cfilter(c)
	return c:IsFaceup() and c:IsEvolution()
end
