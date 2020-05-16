--Saracon, Storm Dynamo
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION,RACE_TRENCH_HUNTER)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_BANISHED,nil,nil,aux.DrawUpToOperation(PLAYER_SELF,3))
end
