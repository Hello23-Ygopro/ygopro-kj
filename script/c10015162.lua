--The Chronarch
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SURVIVOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw, to hand, to shield zone
	aux.AddTriggerEffect(c,0,EVENT_PHASE+PHASE_END,nil,scard.tg1,scard.op1,nil,aux.TurnPlayerCondition(PLAYER_OPPO))
end
--draw, to hand, to shield zone
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		or Duel.IsExistingMatchingCard(aux.ShieldZoneFilter(Card.IsAbleToHand),tp,LOCATION_SZONE,0,1,nil) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g1=Duel.SelectMatchingCard(tp,aux.ShieldZoneFilter(Card.IsAbleToHand),tp,LOCATION_SZONE,0,1,1,nil)
	if g1:GetCount()==0 then return end
	Duel.HintSelection(g1)
	Duel.BreakEffect()
	if Duel.SendtoHand(g1,PLAYER_OWNER,REASON_EFFECT)==0 then return end
	Duel.ShuffleHand(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOSZONE)
	local g2=Duel.SelectMatchingCard(tp,Card.IsAbleToSZone,tp,LOCATION_HAND,0,1,1,nil)
	if g2:GetCount()>0 then
		Duel.SendtoSZone(g2)
	end
end
