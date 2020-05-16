--Absolute Incineration
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--banish
	aux.AddSpellCastEffect(c,0,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--banish
function scard.banfilter1(c,pwr)
	return c:IsFaceup() and c:IsPowerBelow(pwr) and c:KJIsBanishable()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	scard.banish(e,tp,9000)
	Duel.BreakEffect()
	scard.banish(e,tp,6000)
	local g=Duel.GetMatchingGroup(scard.banfilter1,tp,0,LOCATION_BZONE,nil,3000)
	Duel.KJBanish(g,REASON_EFFECT)
end
function scard.banfilter2(c,e,pwr)
	return scard.banfilter1(c,pwr) and c:IsCanBeEffectTarget(e)
end
function scard.banish(e,tp,pwr)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISH)
	local g=Duel.SelectMatchingCard(tp,scard.banfilter2,tp,0,LOCATION_BZONE,1,1,nil,e,pwr)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.KJBanish(g,REASON_EFFECT)
end
