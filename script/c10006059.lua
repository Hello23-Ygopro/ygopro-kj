--Infernus the Awakened
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
	--banish
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--cannot summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SUMMON_CREATURE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_BZONE)
	e1:SetTargetRange(0,1)
	e1:SetTarget(scard.tg2)
	c:RegisterEffect(e1)
end
--banish
function scard.banfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(4000) and c:KJIsBanishable()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.banfilter,0,LOCATION_BZONE,1,1,HINTMSG_BANISH)
scard.op1=aux.TargetCardsOperation(Duel.KJBanish,REASON_EFFECT)
--cannot summon
function scard.tg2(e,c,sump,sumtype,sumpos,targetp)
	return c:IsPowerBelow(4000)
end
