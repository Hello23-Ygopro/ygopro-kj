--Blitzer-Mech Falkora
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MECHA_THUNDER,RACE_STOMPER)
	--creature
	aux.EnableCreatureAttribute(c)
	--fast attack
	aux.EnableEffectCustom(c,EFFECT_FAST_ATTACK)
	--tap
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--tap
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToTap()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.posfilter,0,LOCATION_BZONE,1,1,HINTMSG_TAP)
scard.op1=aux.TargetCardsOperation(Duel.Tap,REASON_EFFECT)
