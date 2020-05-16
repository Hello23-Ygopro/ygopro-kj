--Voksa, Herd Matriarch
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TUSKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to battle zone
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1)
end
--to battle zone
function scard.tbfilter(c)
	return c:IsCreature() and not c:IsEvolution() and c:IsCivilization(CIVILIZATION_NATURE)
end
scard.tg1=aux.SendtoBZoneTarget(scard.tbfilter,LOCATION_HAND,0)
scard.op1=aux.SendtoBZoneOperation(PLAYER_SELF,scard.tbfilter,LOCATION_HAND,0,1)
