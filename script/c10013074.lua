--Grave Call
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to discard pile, return
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--to discard pile, return
function scard.retfilter(c)
	return c:IsCreature() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.KJIsPlayerCanSendDecktoptoDPile(tp,1) and Duel.SelectYesNo(tp,YESNOMSG_TODPILE) then
		Duel.KJSendDecktoptoDPile(tp,1,REASON_EFFECT)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.KJDPileFilter(scard.retfilter),tp,LOCATION_DPILE,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
