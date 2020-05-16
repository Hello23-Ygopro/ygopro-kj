--Forgotten Chief
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CORRUPTED,RACE_SPIRIT_TOTEM)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (cannot be blocked)
	aux.AddStaticEffectCannotBeBlocked(c,LOCATION_BZONE,0,scard.tg1,aux.CannotBeBlockedLessPowerValue)
end
--get ability (cannot be blocked)
scard.tg1=aux.TargetBoolFunction(Card.KJIsRace,RACE_CORRUPTED)
