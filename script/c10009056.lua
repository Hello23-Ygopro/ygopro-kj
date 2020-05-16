--Sunstrike
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--banish or tap, get ability
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--banish or tap, get ability
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,Card.IsFaceup,0,LOCATION_BZONE,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not tc:IsFaceup() then return end
	if tc:IsPowerBelow(5000) then
		Duel.KJBanish(tc,REASON_EFFECT)
	else
		Duel.Tap(tc,REASON_EFFECT)
		local reset_count=(Duel.GetTurnPlayer()~=tp and 2 or 1)
		--do not untap
		aux.AddTempEffectCustom(e:GetHandler(),tc,1,EFFECT_DONOT_UNTAP_START_STEP,RESET_PHASE+PHASE_DRAW,reset_count)
	end
end
--[[
	Rulings
		Q: Can I cast Sunstrike targeting an enemy creature with power 5000 or more that's already tapped?
		A: Yes. If you do, that creature won't untap at the start of your opponent's next turn.
		https://kaijudo.fandom.com/wiki/Sunstrike/Rulings
]]
