--Tainted Quartz
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CORRUPTED,RACE_SPIRIT_QUARTZ)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,2000,nil,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.KJIsRace,RACE_CORRUPTED))
end
