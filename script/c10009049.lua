--Axos the Avenger
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ENFORCER,RACE_ATTACK_RAPTOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,aux.HintTarget,scard.op1)
	--banish
	aux.AddSingleTriggerEffect(c,1,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op2,EFFECT_FLAG_CARD_TARGET)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	if g:GetCount()==0 then return end
	local reset_count=(Duel.GetTurnPlayer()==tp and 2 or 1)
	for tc in aux.Next(g) do
		--blocker
		aux.AddTempEffectBlocker(e:GetHandler(),tc,2,RESET_PHASE+PHASE_DRAW,reset_count)
	end
end
--banish
function scard.banfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(2000) and c:KJIsBanishable()
end
scard.tg1=aux.TargetCardFunction2(PLAYER_SELF,scard.banfilter,0,LOCATION_BZONE,1,1,HINTMSG_BANISH)
scard.op2=aux.TargetCardsOperation(Duel.KJBanish,REASON_EFFECT)
