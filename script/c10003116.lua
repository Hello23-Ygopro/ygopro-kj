--Legionnaire Lizard
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DUNE_GECKO)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,scard.val1,aux.SelfAttackerCondition)
end
--power up
function scard.cfilter(c)
	return c:IsFaceup() and c:IsTapped()
end
function scard.val1(e,c)
	return Duel.GetMatchingGroupCount(scard.cfilter,c:GetControler(),LOCATION_BZONE,0,c)*2000
end
--[[
	References
		1. Perfect Machine King
		https://github.com/Fluorohydride/ygopro-scripts/blob/6324c1c/c18891691.lua#L13
		2. Chthonian Alliance
		https://github.com/Fluorohydride/ygopro-scripts/blob/6324c1c/c46910446.lua#L43
]]
