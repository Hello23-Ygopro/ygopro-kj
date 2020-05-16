--Blade Seer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STORM_PATROL,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--to hand
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--to hand
function scard.thfilter1(c)
	return c:IsCreature() and c:IsAbleToHand()
end
function scard.thfilter2(c)
	return c:IsSpell() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local g=Duel.GetDecktopGroup(tp,3)
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg1=g:FilterSelect(tp,scard.thfilter1,0,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg2=g:FilterSelect(tp,scard.thfilter2,0,1,nil)
	sg1:Merge(sg2)
	if sg1:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(sg1,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg1)
		Duel.ShuffleHand(tp)
	end
	if g:GetCount()>0 then
		aux.SortDeck(tp,tp,3-sg1:GetCount(),SEQ_DECK_BOTTOM)
	end
end
--[[
	References
		1. Dark Magical Circle
		https://github.com/Fluorohydride/ygopro-scripts/blob/cb54f7a/c47222536.lua#L38
]]
