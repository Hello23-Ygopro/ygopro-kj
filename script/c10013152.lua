--Eye of Inquisition
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BATTLE_SPHERE,RACE_DREAD_MASK)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap
	aux.AddSingleTriggerEffect(c,0,EVENT_BANISHED,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	aux.AddTriggerEffect(c,0,EVENT_BANISHED,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.LeaveBZoneCondition())
end
--tap
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToTap()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_BZONE) and chkc:IsControler(1-tp) and scard.posfilter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TAP)
	Duel.SelectTarget(tp,scard.posfilter,tp,0,LOCATION_BZONE,eg:GetCount(),eg:GetCount(),nil)
end
scard.op1=aux.TargetCardsOperation(Duel.Tap,REASON_EFFECT)
