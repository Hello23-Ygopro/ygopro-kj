--Scaradorable the Behemoth
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA,RACE_COLOSSUS)
	aux.AddNameCategory(c,NAMECAT_SCARADORABLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter,scard.evofilter)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
	--to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--banish
	aux.AddSingleTriggerEffect(c,1,EVENT_COME_INTO_PLAY,nil,scard.tg2,scard.op2,EFFECT_FLAG_CARD_TARGET)
end
--vortex evolution
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATIONS_DN)
--to mana zone
function scard.tmfilter(c)
	return c:IsFaceup() and c:IsAbleToMZone()
end
scard.tg1=aux.TargetCardFunction2(PLAYER_SELF,scard.tmfilter,0,LOCATION_BZONE,0,1,HINTMSG_TOMZONE)
scard.op1=aux.TargetCardsOperation(Duel.SendtoMZone,POS_FACEUP_UNTAPPED,REASON_EFFECT)
--banish
function scard.banfilter(c)
	return c:IsFaceup() and c:KJIsBanishable()
end
scard.tg2=aux.TargetCardFunction2(PLAYER_SELF,scard.banfilter,0,LOCATION_BZONE,0,1,HINTMSG_BANISH)
scard.op2=aux.TargetCardsOperation(Duel.KJBanish,REASON_EFFECT)
