--Soul Vortex (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--banish, return
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--banish, return
function scard.banfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(3000) and c:KJIsBanishable()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.banfilter,0,LOCATION_BZONE,1,1,HINTMSG_BANISH)
function scard.retfilter(c)
	return c:IsCreature() and c:IsManaCostBelow(4) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and scard.banfilter(tc) then
		Duel.KJBanish(tc,REASON_EFFECT)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.KJDPileFilter(scard.retfilter),tp,LOCATION_DPILE,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
