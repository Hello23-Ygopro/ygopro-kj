--Megaria, the Deceiver
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DARK_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to discard pile, to battle zone or return
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--to discard pile, to battle zone or return
function scard.filter(c,e,tp)
	return c:IsAbleToBZone(e,0,tp,false,false) or c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.KJSendDecktoptoDPile(tp,3,REASON_EFFECT)
	local g=Duel.GetMatchingGroup(aux.KJDPileFilter(scard.filter),tp,LOCATION_DPILE,0,nil,e,tp)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	local tc=g:RandomSelect(tp,1):GetFirst()
	if tc:IsCreature() and not tc:IsEvolution() and tc:IsAbleToBZone(e,0,tp,false,false) then
		Duel.SendtoBZone(tc,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
	else
		if Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)>0 then Duel.ConfirmCards(1-tp,tc) end
	end
end
