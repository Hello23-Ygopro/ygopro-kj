--Drill Storm
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--banish
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--banish
function scard.banfilter(c,pwr)
	return c:IsFaceup() and c:IsPowerBelow(pwr) and c:KJIsBanishable()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.banfilter,0,LOCATION_BZONE,1,1,HINTMSG_BANISH,nil,3000)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and scard.banfilter(tc,3000) then
		Duel.KJBanish(tc,REASON_EFFECT)
	end
	local g=Duel.GetMatchingGroup(scard.banfilter,tp,0,LOCATION_BZONE,nil,1000)
	Duel.KJBanish(g,REASON_EFFECT)
end
