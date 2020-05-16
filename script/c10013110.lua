--Sergeant Maddox
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BERSERKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,1000,nil,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf(Card.IsCivilization,CIVILIZATION_FIRE))
end
