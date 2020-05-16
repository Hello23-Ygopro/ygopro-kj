--Urth, the Overlord
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--tap
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.TapOperation(nil,scard.posfilter,0,LOCATION_BZONE))
end
--tap
function scard.posfilter(c)
	return c:IsFaceup() and not c:IsHasEffect(EFFECT_BLOCKER)
end
