--Moorna the Vengeful
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--banish
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--banish
function scard.banfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(4000)
end
scard.op1=aux.BanishOperation(PLAYER_SELF,scard.banfilter,LOCATION_BZONE,LOCATION_BZONE,0,2)
