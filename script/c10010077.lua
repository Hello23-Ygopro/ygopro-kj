--Armored Sentinel
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DRAKON,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--protector
	aux.EnableProtector(c)
	--power up
	aux.EnableUpdatePower(c,2000,nil,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf(Card.IsHasEffect,EFFECT_PROTECTOR))
end
