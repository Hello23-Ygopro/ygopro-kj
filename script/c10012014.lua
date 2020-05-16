--Liquid Compulsion
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to battle zone, to hand
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--to battle zone, to hand
function scard.tbfilter(c,e,tp)
	return c:IsCreature() and not c:IsEvolution() and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local g=Duel.GetDecktopGroup(tp,3)
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
	local sg=g:FilterSelect(tp,scard.tbfilter,0,1,nil,e,tp)
	Duel.DisableShuffleCheck()
	if sg:GetCount()>0 then
		Duel.SendtoBZone(sg,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
		g:Sub(sg)
	end
	if g:GetCount()>0 then
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
		Duel.ShuffleHand(tp)
	end
end
