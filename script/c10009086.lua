--Twilight Archon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION,RACE_SHADOW_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--tap, get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--banish
	aux.AddTriggerEffectPlayerCastSpell(c,1,PLAYER_SELF,nil,nil,scard.tg2,scard.op2,EFFECT_FLAG_CARD_TARGET)
end
--tap, get ability
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,Card.IsFaceup,0,LOCATION_BZONE,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not tc:IsFaceup() then return end
	Duel.Tap(tc,REASON_EFFECT)
	local reset_count=(Duel.GetTurnPlayer()~=tp and 2 or 1)
	--do not untap
	aux.AddTempEffectCustom(e:GetHandler(),tc,2,EFFECT_DONOT_UNTAP_START_STEP,RESET_PHASE+PHASE_DRAW,reset_count)
end
--banish
function scard.banfilter(c)
	return c:IsFaceup() and c:IsTapped() and c:KJIsBanishable()
end
scard.tg2=aux.TargetCardFunction(PLAYER_SELF,scard.banfilter,0,LOCATION_BZONE,1,1,HINTMSG_BANISH)
scard.op2=aux.TargetCardsOperation(Duel.KJBanish,REASON_EFFECT)
