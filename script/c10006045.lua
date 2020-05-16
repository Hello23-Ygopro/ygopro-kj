--Belua
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_FIRE_BIRD)
	--creature
	aux.EnableCreatureAttribute(c)
	--cost down
	aux.EnableUpdatePlayCost(c,-1,nil,LOCATION_ALL,0,scard.tg1)
	--get ability (cannot be blocked)
	aux.AddStaticEffectCannotBeBlocked(c,LOCATION_BZONE,0,scard.tg1,aux.CannotBeBlockedLessPowerValue)
end
--cost down, get ability (cannot be blocked)
scard.tg1=aux.TargetBoolFunction(Card.IsRaceCategory,RACECAT_DRAGON)
