--Harmony Wing
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--skirmisher
	aux.EnableSkirmisher(c)
	--untap
	aux.AddSingleTriggerEffect(c,0,EVENT_CUSTOM+EVENT_BLOCK,nil,nil,aux.SelfUntapOperation,nil,scard.con1)
end
--untap
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsPowerBelow(2000)
end
