--Kenina
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_FIRE_BIRD)
	--creature
	aux.EnableCreatureAttribute(c)
	--cost down
	aux.EnableUpdatePlayCost(c,-1,nil,LOCATION_ALL,0,aux.TargetBoolFunction(Card.IsRaceCategory,RACECAT_DRAGON))
	--get ability (powerful attack)
	aux.AddStaticEffectPowerfulAttack(c,2000,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.IsRaceCategory,RACECAT_DRAGON))
end
