--Cyber Cyclones
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--return
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--return
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	scard.return_card(tp)
	Duel.BreakEffect()
	scard.return_card(1-tp)
end
function scard.thfilter(c)
	return c:IsFaceup() and c:IsAbleToHand()
end
function scard.return_card(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_BZONE,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
end
