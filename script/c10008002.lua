--Bottle of Wishes (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--confirm deck (to battle or cast for free or to hand)
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--confirm deck (to battle or cast for free or to hand)
function scard.tbfilter(c,e,tp)
	return c:IsCreature() and not c:IsEvolution() and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.castfilter(c)
	return c:IsSpell() and c:IsManaCostBelow(7)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	Duel.ShuffleDeck(tp)
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	Duel.DisableShuffleCheck()
	Duel.BreakEffect()
	if g:IsExists(scard.tbfilter,1,nil,e,tp) then
		Duel.SendtoBZone(g,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
	elseif g:IsExists(scard.castfilter,1,nil) then
		Duel.CastFree(g)
	elseif g:GetFirst():IsAbleToHand() then
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
		Duel.ShuffleHand(tp)
	end
end
