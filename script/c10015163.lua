--Baelgor, Accursed Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TERROR_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--break
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--break
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetShieldCount(tp)
	local ct2=Duel.GetShieldCount(1-tp)
	if ct2>ct1 then
		Duel.BreakShield(tp,1-tp,ct2-ct1,ct2-ct1,e:GetHandler(),REASON_EFFECT)
	end
end
