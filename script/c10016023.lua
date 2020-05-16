--Tinkerer Tivster
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_VOID_SPAWN,RACE_CYBER_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--clash (to hand, to shield zone)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,aux.ClashTarget(PLAYER_SELF),scard.op1)
end
--clash (to hand, to shield zone)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.Clash(tp) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g1=Duel.SelectMatchingCard(tp,aux.ShieldZoneFilter(Card.IsAbleToHand),tp,LOCATION_SZONE,0,1,1,nil)
	if g1:GetCount()==0 then return end
	Duel.HintSelection(g1)
	if Duel.SendtoHand(g1,PLAYER_OWNER,REASON_EFFECT)==0 then return end
	Duel.ShuffleHand(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOSZONE)
	local g2=Duel.SelectMatchingCard(tp,Card.IsAbleToSZone,tp,LOCATION_HAND,0,1,1,nil)
	if g2:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SendtoSZone(g2)
end
