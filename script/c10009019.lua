--Doomblast Scaradorable
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA)
	aux.AddNameCategory(c,NAMECAT_SCARADORABLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--banish, break shield
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--banish, break shield
function scard.banfilter(c)
	return c:IsFaceup() and c:IsManaCostBelow(4) and c:KJIsBanishable()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.banfilter,0,LOCATION_BZONE,1,1,HINTMSG_BANISH)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and scard.banfilter(tc) then
		Duel.KJBanish(tc,REASON_EFFECT)
	end
	Duel.BreakEffect()
	Duel.BreakShield(tp,1-tp,1,1,e:GetHandler(),REASON_EFFECT)
end
