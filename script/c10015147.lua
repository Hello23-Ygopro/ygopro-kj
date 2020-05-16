--Solstice Chanter
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SNOW_SPRITE)
	--creature
	aux.EnableCreatureAttribute(c)
	--confirm deck (to hand)
	aux.AddSingleTriggerEffect(c,0,EVENT_BANISHED,nil,nil,scard.op1)
end
--confirm deck (to hand)
function scard.thfilter(c)
	return c:IsCreature() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	Duel.ConfirmDecktop(tp,3)
	local g=Duel.GetDecktopGroup(tp,3)
	local sg=g:Filter(scard.thfilter,nil)
	if sg:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
		Duel.ShuffleHand(tp)
	end
	if g:GetCount()>0 then
		aux.SortDeck(tp,tp,3-sg:GetCount(),SEQ_DECK_BOTTOM)
	end
end
--[[
	References
		1. Ma'at
		https://github.com/Fluorohydride/ygopro-scripts/blob/2c4f0ca/c18631392.lua#L71
		2. Spellbook Library of the Heliosphere
		https://github.com/Fluorohydride/ygopro-scripts/blob/6324c1c/c20822520.lua#L65
]]
