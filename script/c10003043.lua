--Hokira, Council of Logos
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw
	aux.AddTriggerEffect(c,0,EVENT_UNTAP_STEP,true,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,2),nil,scard.con1)
end
--draw
function scard.cfilter(c)
	return c:IsFaceup() and c:KJIsRace(RACE_CYBER_LORD)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_BZONE,0,3,nil)
end
