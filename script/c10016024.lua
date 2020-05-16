--Tripwire Teleport
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--return
	aux.AddSpellCastEffect(c,0,scard.tg1,aux.TargetSendtoHandOperation,EFFECT_FLAG_CARD_TARGET)
end
--return
function scard.retfilter(c,pwr)
	return c:IsFaceup() and c:IsPowerBelow(pwr) and c:IsAbleToHand()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local pwr=(Duel.GetTurnPlayer()==tp and 8000 or 4000)
	if chkc then return chkc:IsLocation(LOCATION_BZONE) and scard.retfilter(chkc,pwr) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	Duel.SelectTarget(tp,scard.retfilter,tp,LOCATION_BZONE,LOCATION_BZONE,1,1,nil,pwr)
end
