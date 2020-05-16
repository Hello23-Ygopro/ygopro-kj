--Deathblade Beetle
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MEGABUG)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to hand
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,aux.DecktopSendtoHandOperation(PLAYER_SELF,scard.thfilter,1,0,1,nil,nil,true))
end
--to hand
function scard.thfilter(c)
	return c:IsPowerAbove(5000)
end
