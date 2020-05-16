--Khordia, the Soul Tyrant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SHADOW_CHAMPION,RACE_EARTHSTRIKE_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
	--to battle zone
	aux.AddSingleTriggerEffect(c,1,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op2)
end
--to mana zone
function scard.tmfilter(c)
	return c:IsCreature() and c:IsAbleToMZone()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.KJDPileFilter(scard.tmfilter),tp,LOCATION_DPILE,0,nil)
	Duel.SendtoMZone(g,POS_FACEUP_TAPPED,REASON_EFFECT)
end
--to battle zone
function scard.tbfilter(c)
	return c:IsCreature() and c:IsManaCostBelow(6)
end
scard.tg1=aux.SendtoBZoneTarget(aux.ManaZoneFilter(scard.tbfilter),LOCATION_MZONE,0)
scard.op2=aux.SendtoBZoneOperation(PLAYER_SELF,aux.ManaZoneFilter(scard.tbfilter),LOCATION_MZONE,0,1)
