--Scrutinize
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to hand
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--to hand
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local g=Duel.GetDecktopGroup(tp,3)
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g:FilterSelect(tp,Card.IsAbleToHand,2,2,nil)
	g:Sub(sg)
	if sg:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
		Duel.ShuffleHand(tp)
	end
	if g:GetCount()>0 then
		aux.SortDeck(tp,tp,3-sg:GetCount(),SEQ_DECK_BOTTOM)
	end
end
--[[
	References
		1. Gishki Noellia
		https://github.com/Fluorohydride/ygopro-scripts/blob/cb54f7a/c63942761.lua#L28
]]
