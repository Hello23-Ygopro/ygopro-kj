--Mother Virus
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_VIRUS)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--guard
	aux.EnableGuard(c)
	--draw
	aux.AddTriggerEffect(c,0,EVENT_PHASE+PHASE_END,true,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,1),nil,scard.con1)
end
--draw
function scard.cfilter(c)
	return c:IsFaceup() and c:IsEvolution()
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_BZONE,0,1,nil)
end
