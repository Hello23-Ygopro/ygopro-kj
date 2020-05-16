--Screeching Scaradorable
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA)
	aux.AddNameCategory(c,NAMECAT_SCARADORABLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--banish or get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--banish or get ability
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,Card.IsFaceup,0,LOCATION_BZONE,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not tc:IsFaceup() then return end
	if tc:IsManaCostBelow(2) and tc:KJIsBanishable() then
		Duel.KJBanish(tc,REASON_EFFECT)
	else
		--cannot block
		aux.AddTempEffectCustom(e:GetHandler(),tc,1,EFFECT_CANNOT_BLOCK)
	end
end
