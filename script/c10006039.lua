--Explosive Infantry
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MELT_WARRIOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--banish
	aux.AddSingleTriggerEffect(c,0,EVENT_BANISHED,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--banish
function scard.banfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(1000) and c:KJIsBanishable()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.banfilter,0,LOCATION_BZONE,1,1,HINTMSG_BANISH)
scard.op1=aux.TargetCardsOperation(Duel.KJBanish,REASON_EFFECT)