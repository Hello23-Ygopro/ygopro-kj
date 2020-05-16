--Lava Burst
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--banish
	aux.AddSpellCastEffect(c,0,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--banish
function scard.banfilter1(c)
	return c:IsFaceup() and c:KJIsBanishable()
end
function scard.banfilter2(c,e)
	return scard.banfilter1(c) and c:IsPowerBelow(7000) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISH)
	local g1=Duel.SelectMatchingCard(tp,scard.banfilter1,tp,LOCATION_BZONE,0,1,1,nil)
	if g1:GetCount()==0 then return end
	Duel.HintSelection(g1)
	if Duel.KJBanish(g1,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISH)
	local g2=Duel.SelectMatchingCard(tp,scard.banfilter2,tp,0,LOCATION_BZONE,1,1,nil,e)
	if g2:GetCount()==0 then return end
	Duel.SetTargetCard(g2)
	Duel.KJBanish(g2,REASON_EFFECT)
end
