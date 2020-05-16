--Shaman of the Vigil
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ENFORCER,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_ENFORCER,RACE_BEAST_KIN))
	--get ability (protector)
	aux.AddStaticEffectProtector(c,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.KJIsRace,RACE_BEAST_KIN))
	--untap
	aux.AddTriggerEffect(c,0,EVENT_PHASE+PHASE_END,nil,nil,scard.op1,nil,scard.con1)
end
--untap
function scard.posfilter(c)
	return c:IsFaceup() and c:KJIsRace(RACE_ENFORCER) and c:IsAbleToUntap()
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.IsExistingMatchingCard(scard.posfilter,tp,LOCATION_BZONE,0,1,nil)
end
scard.op1=aux.UntapOperation(nil,scard.posfilter,LOCATION_BZONE,0)
