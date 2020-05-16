--Horrid Stinger
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ROT_WORM)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,2000,nil,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf(Card.KJIsRace,RACE_ROT_WORM))
end
