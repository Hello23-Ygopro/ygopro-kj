--Time Rime
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--get ability
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--get ability
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,Card.IsFaceup,0,LOCATION_BZONE,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not tc:IsFaceup() then return end
	local c=e:GetHandler()
	local reset_count=(Duel.GetTurnPlayer()==tp and 2 or 1)
	--cannot attack
	aux.AddTempEffectCustom(c,tc,1,EFFECT_CANNOT_ATTACK,RESET_PHASE+PHASE_DRAW,reset_count)
	--cannot block
	aux.AddTempEffectCustom(c,tc,2,EFFECT_CANNOT_BLOCK,RESET_PHASE+PHASE_DRAW,reset_count)
end
