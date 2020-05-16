--Dragon of Reflections
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TSUNAMI_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to hand, to shield zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
end
--to hand, to shield zone
scard.tg1=aux.CheckCardFunction(aux.ShieldZoneFilter(Card.IsAbleToHand),LOCATION_SZONE,0)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g1=Duel.SelectMatchingCard(tp,aux.ShieldZoneFilter(Card.IsAbleToHand),tp,LOCATION_SZONE,0,1,1,nil)
	if g1:GetCount()==0 then return end
	Duel.HintSelection(g1)
	if Duel.SendtoHand(g1,PLAYER_OWNER,REASON_EFFECT)==0 then return end
	Duel.ShuffleHand(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOSZONE)
	local g2=Duel.SelectMatchingCard(tp,Card.IsAbleToSZone,tp,LOCATION_HAND,0,1,1,nil)
	if g2:GetCount()==0 then return end
	Duel.SendtoSZone(g2)
end
