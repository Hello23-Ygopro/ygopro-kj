--Aerial Bombardment
--Note: Changed effect to match YGOPro's game system
local scard,sid=aux.GetID()
local ct=5
local min,max=2,2
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to discard pile
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--to discard pile
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetMatchingGroupCount(aux.ShieldZoneFilter(Card.KJIsAbleToDPile),tp,0,LOCATION_SZONE,nil)<ct then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODPILE)
	local g=Duel.SelectMatchingCard(tp,aux.ShieldZoneFilter(Card.KJIsAbleToDPile),tp,0,LOCATION_SZONE,min,max,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.KJSendtoDPile(g,REASON_EFFECT)
end
