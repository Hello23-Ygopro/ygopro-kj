--Luminar Unleashed
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CORRUPTED,RACE_ENFORCER)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_CORRUPTED,RACE_ENFORCER))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--tap
	aux.AddTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--tap
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc:IsControler(tp) and tc:KJIsRace(RACE_CORRUPTED)
end
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToTap()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.posfilter,0,LOCATION_BZONE,1,1,HINTMSG_TAP)
scard.op1=aux.TargetCardsOperation(Duel.Tap,REASON_EFFECT)
