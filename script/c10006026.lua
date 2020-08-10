--Dreadclaw, Dark Herald
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TERROR_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.SendtoHandOperation(nil,aux.KJDPileFilter(scard.thfilter),LOCATION_DPILE,0))
end
--return
function scard.thfilter(c)
	return c:IsRaceCategory(RACECAT_DRAGON)
end
