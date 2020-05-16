--Haven's Elite
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--banish replace (to shield)
	aux.AddSingleReplaceEffectBanish(c,0,scard.tg1,scard.op1)
	aux.AddReplaceEffectBanish(c,0,scard.tg2,scard.op2,scard.val1)
end
--banish replace (to shield)
scard.tg1=aux.SingleReplaceBanishTarget(Card.IsAbleToSZone)
scard.op1=aux.SingleReplaceBanishOperation(Duel.SendtoSZone)
function scard.repfilter(c,tp)
	return c:IsLocation(LOCATION_BZONE) and c:IsFaceup() and c:KJIsRace(RACE_SKYFORCE_CHAMPION)
		and not c:IsEvolution() and c:IsControler(tp) and not c:IsReason(REASON_REPLACE) and c:IsAbleToSZone()
end
function scard.tg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return eg:IsExists(scard.repfilter,1,c,tp) end
	local g=eg:Filter(scard.repfilter,c,tp)
	g:KeepAlive()
	e:SetLabelObject(g)
	return true
end
function scard.val1(e,c)
	return scard.repfilter(c,e:GetHandlerPlayer())
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.SendtoSZone(e:GetLabelObject())
end
