--Ember Titan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ROCK_BRUTE,RACE_COLOSSUS)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--banish
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.BanishOperation(nil,scard.banfilter,0,LOCATION_BZONE))
end
--banish
function scard.banfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(2000)
end
