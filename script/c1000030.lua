--Necrose, Nightmare Bloom
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ROT_WORM,RACE_TREE_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--return, to battle zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--return, to battle zone
function scard.thfilter(c)
	return c:IsCreature() and c:IsAbleToHand()
end
function scard.tbfilter(c,e,tp)
	return c:IsCreature() and not c:IsEvolution() and c:IsManaCostBelow(5) and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g1=Duel.SelectMatchingCard(tp,aux.KJDPileFilter(scard.thfilter),tp,LOCATION_DPILE,0,1,1,nil)
	if g1:GetCount()>0 and Duel.SendtoHand(g1,PLAYER_OWNER,REASON_EFFECT)>0 then
		Duel.ConfirmCards(1-tp,g1)
		Duel.ShuffleHand(tp)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
	local g2=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_HAND,0,0,1,nil,e,tp)
	if g2:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SendtoBZone(g2,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
end
