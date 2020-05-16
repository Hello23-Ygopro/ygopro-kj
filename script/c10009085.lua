--Wildstrider Ramnoth
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_PRIMAL_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to mana zone
	aux.AddTriggerEffect(c,0,EVENT_UNTAP_STEP,true,scard.tg1,scard.op1,nil,scard.con1)
end
--to mana zone
scard.con1=aux.TurnPlayerCondition(PLAYER_SELF)
scard.tg1=aux.DecktopSendtoMZoneTarget(PLAYER_SELF)
scard.op1=aux.DecktopSendtoMZoneOperation(PLAYER_SELF,1)
