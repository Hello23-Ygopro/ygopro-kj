--Void Trap
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--get ability (power down)
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--get ability (power down)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,Card.IsFaceup,LOCATION_BZONE,LOCATION_BZONE,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not tc:IsFaceup() then return end
	local desc_id=(Duel.GetTurnPlayer()==tp and 2 or 1)
	local val=(Duel.GetTurnPlayer()==tp and -6000 or -3000)
	--power down
	aux.AddTempEffectUpdatePower(e:GetHandler(),tc,desc_id,val)
end
