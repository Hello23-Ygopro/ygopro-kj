--Twin-Cannon Maelstrom
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (powerful attack)
	aux.AddStaticEffectPowerfulAttack(c,2000,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf())
end
