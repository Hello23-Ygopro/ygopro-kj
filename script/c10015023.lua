--Skyforce Adjutant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (blocker)
	aux.AddStaticEffectBlocker(c,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.IsPowerAbove,6000))
end
