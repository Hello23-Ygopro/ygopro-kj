--Battlebred Defender
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ENFORCER,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--skirmisher
	aux.EnableSkirmisher(c)
	--get ability (powerful attack)
	aux.AddStaticEffectPowerfulAttack(c,4000,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.IsEvolution))
	--get ability (break extra shield)
	aux.EnableEffectCustom(c,EFFECT_BREAK_EXTRA_SHIELD,nil,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.IsEvolution))
end
