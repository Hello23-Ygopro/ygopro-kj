--Morphing Pod
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--to deck, to battle zone
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to deck, to battle zone
function scard.tdfilter(c)
	return c:IsFaceup() and c:IsAbleToDeck()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.tdfilter,LOCATION_BZONE,LOCATION_BZONE,1,1,HINTMSG_TODECK)
function scard.tbfilter(c,e,tp,cost)
	return c:IsCreature() and not c:IsEvolution() and c:IsManaCostBelow(cost) and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc1=Duel.GetFirstTarget()
	if tc1 and tc1:IsRelateToEffect(e) and scard.tdfilter(tc1) then
		Duel.SendtoDeck(tc1,PLAYER_OWNER,SEQ_DECK_BOTTOM,REASON_EFFECT)
	end
	local p=tc1:GetControler()
	local g=Duel.GetMatchingGroup(scard.tbfilter,p,LOCATION_DECK,0,nil,e,tp,tc1:GetManaCost())
	local ct=Duel.GetFieldGroupCount(p,LOCATION_DECK,0)
	if ct==0 then return end
	local seq=-1
	local tbcard=nil
	for tc2 in aux.Next(g) do
		if tc2:GetSequence()>seq then
			seq=tc2:GetSequence()
			tbcard=tc2
		end
	end
	if seq==-1 then
		Duel.ConfirmDecktop(p,ct)
		Duel.ShuffleDeck(p)
		return
	end
	Duel.ConfirmDecktop(p,ct-seq)
	if tbcard:IsAbleToBZone(e,0,p,false,false,POS_FACEUP_UNTAPPED) then
		Duel.DisableShuffleCheck()
		if ct-seq==1 then Duel.SendtoBZone(tbcard,0,p,p,false,false,POS_FACEUP_UNTAPPED)
		else
			Duel.SendtoBZoneStep(tbcard,0,p,p,false,false,POS_FACEUP_UNTAPPED)
			for i=1,ct-seq do
				local mg=Duel.GetDecktopGroup(p,1)
				Duel.MoveSequence(mg:GetFirst(),SEQ_DECK_BOTTOM)
			end
			Duel.SendtoBZoneComplete()
		end
	else
		for i=1,ct-seq do
			local mg=Duel.GetDecktopGroup(p,1)
			Duel.MoveSequence(mg:GetFirst(),SEQ_DECK_BOTTOM)
		end
	end
end
