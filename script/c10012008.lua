--Radiant Purification
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to deck, tap
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to deck, tap
function scard.tdfilter(c)
	return c:IsFaceup() and c:IsAbleToDeck()
end
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToTap()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.tdfilter,0,LOCATION_BZONE,0,2,HINTMSG_TODECK)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g1:GetCount()>0 then
		Duel.SendtoDeck(g1,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT)
	end
	local g2=Duel.GetMatchingGroup(scard.posfilter,tp,0,LOCATION_BZONE,nil)
	Duel.BreakEffect()
	Duel.Tap(g2,REASON_EFFECT)
end
