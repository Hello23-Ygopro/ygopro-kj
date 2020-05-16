--Repulse
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--tap, to shield zone
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--tap, to shield zone
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToTap()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.posfilter,0,LOCATION_BZONE,1,1,HINTMSG_TAP)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and scard.posfilter(tc) then
		Duel.Tap(tc,REASON_EFFECT)
	end
	if Duel.GetShieldCount(tp)<=2 then
		Duel.SendDecktoptoSZone(tp,1)
	end
end
