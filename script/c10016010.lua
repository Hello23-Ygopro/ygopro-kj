--Photon Snare
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--tap
	aux.AddSpellCastEffect(c,0,scard.tg1,aux.TargetCardsOperation(Duel.Tap,REASON_EFFECT),EFFECT_FLAG_CARD_TARGET)
end
--tap
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToTap()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ct=(Duel.GetTurnPlayer()==tp and 2 or 1)
	if chkc then return chkc:IsLocation(LOCATION_BZONE) and chkc:IsControler(1-tp) and scard.posfilter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TAP)
	Duel.SelectTarget(tp,scard.posfilter,tp,0,LOCATION_BZONE,ct,ct,nil)
end
