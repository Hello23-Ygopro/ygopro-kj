--Reap and Sow
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to hand, to mana zone
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--to hand, to mana zone
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local g=Duel.GetDecktopGroup(tp,2)
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g:FilterSelect(tp,Card.IsAbleToHand,1,1,nil)
	g:Sub(sg)
	Duel.DisableShuffleCheck()
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
		Duel.ShuffleHand(tp)
	end
	if g:GetCount()>0 then
		Duel.SendtoMZone(g,POS_FACEUP_UNTAPPED,REASON_EFFECT)
	end
end
--[[
	References
		1. Chronomaly Technology
		https://github.com/Fluorohydride/ygopro-scripts/blob/c04a9da/c90951921.lua#L54
]]
