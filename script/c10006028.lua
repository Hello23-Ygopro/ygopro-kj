--Gloom Tomb
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to grave, return
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--to grave, return
function scard.thfilter(c)
	return c:IsCreature() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.KJSendDecktoptoDPile(tp,3,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.KJDPileFilter(scard.thfilter),tp,LOCATION_DPILE,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
