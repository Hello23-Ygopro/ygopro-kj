--Prototype Gunship
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STORM_PATROL,RACE_STOMPER)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--skirmisher
	aux.EnableSkirmisher(c)
	--banish
	aux.AddSingleTriggerEffect(c,0,EVENT_BANISHED,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--banish
function scard.banfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(2000) and c:KJIsBanishable()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.banfilter,0,LOCATION_BZONE,1,1,HINTMSG_BANISH)
scard.op1=aux.TargetCardsOperation(Duel.KJBanish,REASON_EFFECT)
