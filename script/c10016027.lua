--Anguished Haunt
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SPECTER)
	--creature
	aux.EnableCreatureAttribute(c)
	--banish
	aux.AddTriggerEffect(c,0,EVENT_PHASE+PHASE_END,nil,nil,scard.op1,nil,scard.con1)
end
--banish
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and e:GetHandler():GetAttackAnnouncedCount()>0
end
scard.op1=aux.BanishOperation(PLAYER_SELF,Card.IsFaceup,LOCATION_BZONE,0,1)
