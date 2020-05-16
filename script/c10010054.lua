--Essence Shade
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CORRUPTED,RACE_SPECTER)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,1000,nil,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.KJIsRace,RACE_CORRUPTED))
end
