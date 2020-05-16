--Kivu, Ingenious Shaman
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_VIRUS,RACE_SPIRIT_TOTEM)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--return, to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
end
--return, to mana zone
scard.tg1=aux.CheckCardFunction(aux.ManaZoneFilter(Card.IsAbleToHand),LOCATION_MZONE,0)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.ManaZoneFilter(Card.IsAbleToHand),tp,LOCATION_MZONE,0,1,1,nil)
	if g:GetCount()==0 or Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)==0 then return end
	Duel.ConfirmCards(1-tp,g)
	Duel.SendDecktoptoMZone(tp,1,POS_FACEUP_UNTAPPED,REASON_EFFECT)
end
