--Infernal Taskmaster
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SHADOW_CHAMPION,RACE_ROCK_BRUTE)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1,nil,scard.con1)
end
--get ability
function scard.cfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(scard.cfilter,e:GetHandler(),tp)
	g:KeepAlive()
	e:SetLabelObject(g)
	return g:GetCount()>0
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local c=e:GetHandler()
	for tc in aux.Next(g) do
		--fast attack
		aux.AddTempEffectCustom(c,tc,2,EFFECT_FAST_ATTACK)
		--banish
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(sid,1))
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetRange(LOCATION_BZONE)
		e1:SetCountLimit(1)
		e1:SetCondition(scard.con2)
		e1:SetOperation(scard.op2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
--banish
function scard.con2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetAttackedCount()>0
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.KJBanish(e:GetHandler(),REASON_EFFECT)
end
