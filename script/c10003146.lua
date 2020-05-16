--Launcher Locust
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MEGABUG)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (cannot be blocked)
	aux.AddStaticEffectCannotBeBlocked(c,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf(Card.KJIsRace,RACE_MEGABUG),aux.CannotBeBlockedLessPowerValue)
end
