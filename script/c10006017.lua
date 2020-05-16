--Kindrix the Psionic
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TSUNAMI_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRaceCategory,RACECAT_DRAGON))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--cannot be blocked
	aux.EnableCannotBeBlocked(c)
	--draw
	aux.AddTriggerEffect(c,0,EVENT_PHASE+PHASE_END,true,aux.DrawTarget(PLAYER_SELF),scard.op1,nil,scard.con1)
end
--draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and (Duel.GetBrokenShieldCount(tp)>0 or Duel.GetBrokenShieldCount(1-tp)>0)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetBrokenShieldCount(tp)+Duel.GetBrokenShieldCount(1-tp)
	Duel.Draw(tp,ct,REASON_EFFECT)
end
