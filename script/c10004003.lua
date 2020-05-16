--Cobalt, the Storm Knight
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ENFORCER)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_ENFORCER))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to shield zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
end
--to shield zone
scard.tg1=aux.DecktopSendtoSZoneTarget(PLAYER_SELF)
scard.op1=aux.DecktopSendtoSZoneOperation(PLAYER_SELF,1)
