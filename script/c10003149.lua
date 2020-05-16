--Mighty Shouter
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to mana zone
function scard.tmfilter(c)
	return c:IsFaceup() and c:IsManaCostBelow(3) and c:IsAbleToMZone()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.tmfilter,0,LOCATION_BZONE,1,1,HINTMSG_TOMZONE)
scard.op1=aux.TargetCardsOperation(Duel.SendtoMZone,POS_FACEUP_UNTAPPED,REASON_EFFECT)
