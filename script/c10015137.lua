--Lunar Boar
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TUSKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--cost down
	aux.EnableUpdatePlayCost(c,-1,nil,LOCATION_ALL,0,aux.TargetBoolFunction(Card.IsPowerBelow,6000))
	--draw
	aux.AddTriggerEffect(c,0,EVENT_PHASE+PHASE_END,true,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,1),nil,scard.con1)
end
--draw
function scard.cfilter(c)
	return c:IsFaceup() and c:IsPowerAbove(6000)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_BZONE,0,1,nil)
end
