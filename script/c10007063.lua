--Noble Rumbling Terrasaur
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TUSKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_TUSKER))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	aux.AddTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg2,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--to mana zone
function scard.tmfilter(c,cost)
	return c:IsFaceup() and c:GetManaCost()<cost and c:IsAbleToMZone()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local cost=e:GetHandler():GetManaCost()
	if chkc then return chkc:IsLocation(LOCATION_BZONE) and chkc:IsControler(1-tp) and scard.tmfilter(chkc,cost) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOMZONE)
	Duel.SelectTarget(tp,scard.tmfilter,tp,0,LOCATION_BZONE,eg:GetCount(),eg:GetCount(),nil,cost)
end
scard.op1=aux.TargetCardsOperation(Duel.SendtoMZone,POS_FACEUP_UNTAPPED,REASON_EFFECT)
function scard.cfilter(c,tp)
	return c:IsFaceup() and c:KJIsRace(RACE_TUSKER) and c:IsControler(tp)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.cfilter,1,e:GetHandler(),tp)
end
function scard.tg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local cost=eg:GetFirst():GetManaCost()
	if chkc then return chkc:IsLocation(LOCATION_BZONE) and chkc:IsControler(1-tp) and scard.tmfilter(chkc,cost) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOMZONE)
	Duel.SelectTarget(tp,scard.tmfilter,tp,0,LOCATION_BZONE,eg:GetCount(),eg:GetCount(),nil,cost)
end
