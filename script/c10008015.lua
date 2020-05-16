--Dragon's Breath (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--banish
	aux.AddSpellCastEffect(c,0,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--banish
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	scard.banish(e,tp,3000)
	scard.banish(e,tp,2000)
	scard.banish(e,tp,1000)
end
function scard.banfilter(c,e,pwr)
	return c:IsFaceup() and c:IsPowerBelow(pwr) and c:KJIsBanishable() and c:IsCanBeEffectTarget(e)
end
function scard.banish(e,tp,pwr)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISH)
	local g=Duel.SelectMatchingCard(tp,scard.banfilter,tp,0,LOCATION_BZONE,1,1,nil,e,pwr)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.KJBanish(g,REASON_EFFECT)
end
