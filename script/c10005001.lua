--Necrodragon of Vile Ichor
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TERROR_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--slayer
	aux.EnableSlayer(c)
	--break
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--break
function scard.cfilter(c)
	return c:IsFaceup() and c:IsRaceCategory(RACECAT_DRAGON)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(scard.cfilter,tp,LOCATION_BZONE,0,nil)
	Duel.BreakShield(tp,1-tp,ct,ct,e:GetHandler(),REASON_EFFECT)
end
