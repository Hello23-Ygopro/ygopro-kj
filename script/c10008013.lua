--Bolshack Dragon (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--power up
	aux.EnableUpdatePower(c,scard.val1,aux.SelfAttackerCondition)
end
--power up
function scard.val1(e,c)
	return Duel.GetMatchingGroupCount(aux.KJDPileFilter(Card.IsCivilization),c:GetControler(),LOCATION_DPILE,0,nil,CIVILIZATION_FIRE)*1000
end
--[[
	References
		1. Worm Solid
		https://github.com/Fluorohydride/ygopro-scripts/blob/b81455f/c3204467.lua#L22
		2. Pilgrim Reaper
		https://github.com/Fluorohydride/ygopro-scripts/blob/2f8b6d0/c45742626.lua#L30
]]
