--Muk'tak, Lifespark Guide
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--return, to mana zone
	aux.AddTriggerEffect(c,0,EVENT_PHASE+PHASE_END,true,scard.tg1,scard.op1,nil,scard.con1)
end
--return, to mana zone
function scard.cfilter(c)
	return c:IsFaceup() and c:IsPowerAbove(6000)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_BZONE,0,1,nil)
end
function scard.thfilter(c)
	return c:IsCreature() and c:IsAbleToHand()
end
scard.tg1=aux.CheckCardFunction(aux.ManaZoneFilter(scard.thfilter),LOCATION_MZONE,0)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.ManaZoneFilter(scard.thfilter),tp,LOCATION_MZONE,0,1,1,nil)
	if g:GetCount()==0 or Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)==0 then return end
	Duel.ConfirmCards(1-tp,g)
	Duel.SendDecktoptoMZone(tp,1,POS_FACEUP_UNTAPPED,REASON_EFFECT)
end
