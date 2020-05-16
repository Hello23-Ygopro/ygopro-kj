--Deep Mind Probe
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--to hand
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--to hand
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local g=Duel.GetDecktopGroup(tp,3)
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg1=g:FilterSelect(tp,Card.IsAbleToHand,1,1,nil)
	g:Sub(sg1)
	if sg1:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(sg1,PLAYER_OWNER,REASON_EFFECT)
		Duel.ShuffleHand(tp)
	end
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECKBOT)
		local sg2=g:Select(tp,1,1,nil)
		Duel.MoveSequence(sg2:GetFirst(),SEQ_DECK_BOTTOM)
	end
end
