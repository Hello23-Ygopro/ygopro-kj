--Finbarr's Dreadnought
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_COMPLEX)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,2))
	--banish replace (return)
	aux.AddReplaceEffectBanish(c,1,scard.tg1,scard.op1,scard.val1)
end
--banish replace (return)
function scard.repfilter(c,tp)
	return c:IsLocation(LOCATION_BZONE) and c:IsFaceup()
		and c:IsControler(tp) and not c:IsReason(REASON_REPLACE) and c:IsAbleToHand()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
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
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.SendtoHand(e:GetLabelObject(),PLAYER_OWNER,REASON_EFFECT+REASON_REPLACE)
end
