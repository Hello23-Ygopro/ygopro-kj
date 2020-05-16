--The Arbiter
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ENFORCER)
	--creature
	aux.EnableCreatureAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--tap
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--tap
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToTap()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.posfilter,0,LOCATION_BZONE,0,2,HINTMSG_TAP)
scard.op1=aux.TargetCardsOperation(Duel.Tap,REASON_EFFECT)
