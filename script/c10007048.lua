--Ember-Eye
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ATTACK_RAPTOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (powerful attack)
	aux.AddStaticEffectPowerfulAttack(c,2000,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf(),aux.SelfTappedCondition)
end
