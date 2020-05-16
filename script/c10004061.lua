--Ra-Vu the Stormbringer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_SKYFORCE_CHAMPION))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--untap
	aux.AddTriggerEffect(c,0,EVENT_PHASE+PHASE_END,nil,nil,scard.op1,nil,scard.con1)
	--get ability (blocker)
	aux.AddStaticEffectBlocker(c,LOCATION_BZONE,0)
end
--untap
function scard.cfilter(c)
	return c:IsFaceup() and c:IsAbleToUntap()
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_BZONE,0,1,nil)
end
scard.op1=aux.UntapOperation(nil,Card.IsFaceup,LOCATION_BZONE,0)
