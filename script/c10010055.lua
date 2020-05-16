--Fate's Hand
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--return or get ability
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--return or get ability
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,Card.IsFaceup,LOCATION_BZONE,LOCATION_BZONE,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not tc:IsFaceup() then return end
	if tc:IsPowerBelow(3000) then
		Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)
	else
		--power down
		aux.AddTempEffectUpdatePower(e:GetHandler(),tc,1,-3000)
	end
end
