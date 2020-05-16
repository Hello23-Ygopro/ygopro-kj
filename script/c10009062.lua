--Mar-Blurpa the Weaponsmith
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_EARTH_EATER,RACE_DRAKON)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,aux.HintTarget,scard.op1)
	--banish
	aux.AddSingleTriggerEffect(c,1,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op2,EFFECT_FLAG_CARD_TARGET)
end
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp,chk)
	if Duel.IsPlayerCanDraw(tp,1) and Duel.SelectYesNo(tp,YESNOMSG_DRAW) then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
--banish
function scard.banfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(2000) and c:KJIsBanishable()
end
scard.tg1=aux.TargetCardFunction2(PLAYER_SELF,scard.banfilter,0,LOCATION_BZONE,1,1,HINTMSG_BANISH)
scard.op2=aux.TargetCardsOperation(Duel.KJBanish,REASON_EFFECT)
