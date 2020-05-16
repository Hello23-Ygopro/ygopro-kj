--Ammo Train
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STOMPER)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (powerful attack)
	aux.AddStaticEffectPowerfulAttack(c,1000,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf())
end
