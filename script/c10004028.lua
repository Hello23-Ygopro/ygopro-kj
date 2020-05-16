--Olgate, Knight of Shadow
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SHADOW_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--untap
	aux.AddTriggerEffect(c,0,EVENT_BANISHED,nil,nil,scard.op1,nil,scard.con1)
end
--untap
scard.con1=aux.AND(aux.LeaveBZoneCondition(PLAYER_SELF),aux.SelfTappedCondition)
scard.op1=aux.SelfUntapOperation
