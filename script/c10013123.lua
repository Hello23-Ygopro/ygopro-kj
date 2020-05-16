--Anjak, the All-Kin
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_NATURE))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--banish replace (to mana zone)
	aux.AddSingleReplaceEffectBanish(c,0,scard.tg1,scard.op1)
	--to battle zone
	aux.AddSingleTriggerEffect(c,1,EVENT_TO_MZONE,true,scard.tg2,scard.op2,nil,aux.SelfLeaveBZoneCondition)
end
--banish replace (to mana zone)
scard.tg1=aux.SingleReplaceBanishTarget(Card.IsAbleToMZone)
scard.op1=aux.SingleReplaceBanishOperation(Duel.SendtoMZone,POS_FACEUP_UNTAPPED,REASON_EFFECT+REASON_REPLACE)
--to battle zone
function scard.tbfilter(c)
	return c:IsCreature() and not c:IsEvolution() and c:IsManaCostBelow(5)
end
scard.tg2=aux.SendtoBZoneTarget(aux.ManaZoneFilter(scard.tbfilter),LOCATION_MZONE,0)
scard.op2=aux.SendtoBZoneOperation(PLAYER_SELF,aux.ManaZoneFilter(scard.tbfilter),LOCATION_MZONE,0,1)
