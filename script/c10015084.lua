--Sinister Scheme
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--discard, banish
	aux.AddSpellCastEffect(c,0,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--discard, banish
function scard.banfilter(c,e)
	return c:IsFaceup() and c:KJIsBanishable() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.DiscardHand(tp,aux.TRUE,0,1,REASON_EFFECT,e:GetHandler())==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISH)
	local g=Duel.SelectMatchingCard(tp,scard.banfilter,tp,0,LOCATION_BZONE,1,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.KJBanish(g,REASON_EFFECT)
end
