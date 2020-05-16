--Mesmerize
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--confirm hand (discard)
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--confirm hand (discard)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()==0 then return end
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local sg=g:Select(tp,1,1,nil)
	Duel.KJSendtoDPile(sg,REASON_EFFECT+REASON_DISCARD)
	Duel.ShuffleHand(1-tp)
end
