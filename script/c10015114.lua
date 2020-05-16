--Runes of Fortune
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--confirm deck (to hand or to discard pile)
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--confirm deck (to hand or to discard pile)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	Duel.ConfirmDecktop(tp,3)
	local g=Duel.GetDecktopGroup(tp,3)
	Duel.DisableShuffleCheck()
	if g:GetClassCount(Card.GetManaCost)==g:GetCount() and g:IsExists(Card.IsAbleToHand,1,nil) then
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		Duel.ShuffleHand(tp)
	else
		Duel.KJSendtoDPile(g,REASON_EFFECT)
	end
end
--[[
	References
		1. Gishki Noellia
		https://github.com/Fluorohydride/ygopro-scripts/blob/cb54f7a/c63942761.lua#L21
		2. Spellbook Library of the Heliosphere
		https://github.com/Fluorohydride/ygopro-scripts/blob/6324c1c/c20822520.lua#L64
]]
