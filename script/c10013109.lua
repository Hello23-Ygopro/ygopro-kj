--Searing Spears
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--banish
	aux.AddSpellCastEffect(c,0,scard.tg1,aux.TargetCardsOperation(Duel.KJBanish,REASON_EFFECT),EFFECT_FLAG_CARD_TARGET)
end
--banish
function scard.cfilter(c)
	return c:IsFaceup() and c:IsEvolution()
end
function scard.banfilter(c,pwr)
	return c:IsFaceup() and c:IsPowerBelow(pwr) and c:KJIsBanishable()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local pwr=(Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_BZONE,0,1,nil) and 8000 or 6000)
	if chkc then return chkc:IsLocation(LOCATION_BZONE) and chkc:IsControler(1-tp) and scard.banfilter(chkc,pwr) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISH)
	Duel.SelectTarget(tp,scard.banfilter,tp,0,LOCATION_BZONE,1,1,nil,pwr)
end
