--Temporal Tinkering
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to hand, draw
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--to hand, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local g=Duel.GetDecktopGroup(tp,1)
	Duel.ConfirmCards(tp,g)
	if Duel.SelectYesNo(tp,YESNOMSG_TODECKBOT) then
		Duel.MoveSequence(g:GetFirst(),SEQ_DECK_BOTTOM)
	end
	Duel.BreakEffect()
	Duel.Draw(tp,1,REASON_EFFECT)
end
