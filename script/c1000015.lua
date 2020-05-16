--Old Man Winter
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TREE_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--draw, to battle zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--draw, to battle zone
function scard.tbfilter(c,e,tp)
	return c:IsCreature() and not c:IsEvolution() and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerCanDraw(tp,1) and Duel.SelectYesNo(tp,YESNOMSG_DRAW) then
		Duel.Draw(tp,3,REASON_EFFECT)
	end
	if Duel.IsPlayerCanDraw(1-tp,1) and Duel.SelectYesNo(1-tp,YESNOMSG_DRAW) then
		Duel.Draw(1-tp,3,REASON_EFFECT)
		Duel.ShuffleHand(1-tp)
	end
	local bzone_count=Duel.GetLocationCount(1-tp,LOCATION_BZONE)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOBZONE)
	local g=Duel.SelectMatchingCard(1-tp,scard.tbfilter,1-tp,LOCATION_HAND,0,0,bzone_count,nil,e,tp)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SendtoBZone(g,0,1-tp,1-tp,false,false,POS_FACEUP_UNTAPPED)
end
