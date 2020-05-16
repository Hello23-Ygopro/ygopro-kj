--Death Liger the Justicar
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION,RACE_SHADOW_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--get ability (power down)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--tap
	aux.AddTriggerEffect(c,1,EVENT_BANISHED,nil,scard.tg2,scard.op2,EFFECT_FLAG_CARD_TARGET,aux.LeaveBZoneCondition(PLAYER_OPPO))
end
--get ability (power down)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,Card.IsFaceup,0,LOCATION_BZONE,1,1,HINTMSG_TARGET)
scard.op1=aux.TargetUpdatePowerOperation(2,-3000)
--tap
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToTap()
end
function scard.tg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_BZONE) and chkc:IsControler(1-tp) and scard.posfilter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TAP)
	Duel.SelectTarget(tp,scard.posfilter,tp,0,LOCATION_BZONE,eg:GetCount(),eg:GetCount(),nil)
end
scard.op2=aux.TargetCardsOperation(Duel.Tap,REASON_EFFECT)
