--Briar Pit
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--to mana zone
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to mana zone
function scard.tmfilter(c,pwr)
	return c:IsFaceup() and c:IsPowerBelow(pwr) and c:IsAbleToMZone()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local pwr=(Duel.GetTurnPlayer()==tp and 6000 or 3000)
	if chkc then return chkc:IsLocation(LOCATION_BZONE) and chkc:IsControler(1-tp) and scard.tmfilter(chkc,pwr) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOMZONE)
	Duel.SelectTarget(tp,scard.tmfilter,tp,0,LOCATION_BZONE,1,1,nil,pwr)
end
scard.op1=aux.TargetCardsOperation(Duel.SendtoMZone,POS_FACEUP_UNTAPPED,REASON_EFFECT)
