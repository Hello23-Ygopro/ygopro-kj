--Regent Sasha
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ANGEL_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_LIGHT))
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
	--unleash (get ability)
	aux.EnableUnleash(c,0,nil,scard.op1)
end
--unleash (get ability)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local reset_count=(Duel.GetTurnPlayer()==tp and 2 or 1)
	--cannot leave
	aux.AddTempEffectCannotLeaveBZone(c,c,3,RESET_PHASE+PHASE_DRAW,reset_count)
	--break replace (discard)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_SEND_REPLACE)
	e1:SetTarget(scard.tg1)
	e1:SetValue(scard.val1)
	e1:SetOperation(scard.op2)
	e1:SetReset(RESET_PHASE+PHASE_DRAW,reset_count)
	Duel.RegisterEffect(e1,tp)
end
--break replace (discard)
function scard.repfilter(c,tp)
	return c:IsLocation(LOCATION_SZONE) and c:IsControler(tp)
		and c:GetDestination()~=LOCATION_SZONE and not c:IsReason(REASON_REPLACE)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(scard.repfilter,1,nil,tp) and bit.band(r,REASON_BREAK)~=0
		and Duel.IsExistingMatchingCard(Card.IsCreature,tp,LOCATION_HAND,0,1,nil) end
	return Duel.SelectYesNo(tp,aux.Stringid(sid,2))
end
function scard.val1(e,c)
	return scard.repfilter(c,e:GetHandlerPlayer())
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.DiscardHand(tp,Card.IsCreature,1,1,REASON_EFFECT)
end
