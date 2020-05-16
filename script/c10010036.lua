--Choten's Stalker Sphere
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CORRUPTED,RACE_ENFORCER)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (blocker)
	aux.AddStaticEffectBlocker(c,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.KJIsRace,RACE_CORRUPTED))
end
