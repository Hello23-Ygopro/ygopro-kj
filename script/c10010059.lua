--Blitz Commando
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CORRUPTED,RACE_STOMPER)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (fast attack)
	aux.EnableEffectCustom(c,EFFECT_FAST_ATTACK,nil,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.KJIsRace,RACE_CORRUPTED))
end
