--Scalding Surge
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--banish or return
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--banish or return
function scard.filter(c)
	return c:IsFaceup() and (c:KJIsBanishable() or c:IsAbleToHand())
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.filter,0,LOCATION_BZONE,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not scard.filter(tc) then return end
	if tc:IsPowerBelow(3000) then
		Duel.KJBanish(tc,REASON_EFFECT)
	else
		Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)
	end
end
