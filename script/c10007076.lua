--Piercing Judgment
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--return, tap
	aux.AddSpellCastEffect(c,0,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--return, tap
function scard.thfilter(c,e)
	return c:IsFaceup() and c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.posfilter(c,e)
	return c:IsFaceup() and c:IsAbleToTap() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g1=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_BZONE,LOCATION_BZONE,1,1,nil,e)
	if g1:GetCount()>0 then
		Duel.SetTargetCard(g1)
		Duel.SendtoHand(g1,PLAYER_OWNER,REASON_EFFECT)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TAP)
	local g2=Duel.SelectMatchingCard(tp,scard.posfilter,tp,0,LOCATION_BZONE,1,1,nil,e)
	if g2:GetCount()==0 then return end
	Duel.SetTargetCard(g2)
	Duel.Tap(g2,REASON_EFFECT)
end
