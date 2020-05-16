--Krakus the Dominator
--WORK IN PROGRESS
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BERSERKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--enter tapped
	aux.EnableEffectCustom(c,EFFECT_ENTER_BZONE_TAPPED,nil,0,LOCATION_ALL,aux.TargetBoolFunction(Card.IsHasEffect,EFFECT_BLOCKER))
	--send replace (to discard pile)
	--WORK IN PROGRESS
end
