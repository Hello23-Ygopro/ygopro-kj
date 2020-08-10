--Magnet Mech Glu-urrgle
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	aux.AddNameCategory(c,NAMECAT_GLUURRGLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_BATTLE_CONFIRM,true,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--return
scard.con1=aux.UnblockedCondition
function scard.thfilter(c)
	return c:IsFaceup() and c:IsManaCostBelow(5) and c:IsAbleToHand()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.thfilter,LOCATION_BZONE,LOCATION_BZONE,1,1,HINTMSG_RTOHAND)
scard.op1=aux.TargetSendtoHandOperation
