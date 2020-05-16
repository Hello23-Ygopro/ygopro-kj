--Molten Stonesaur
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ROCK_BRUTE)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_FIRE))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--banish
	aux.AddSingleTriggerEffect(c,0,EVENT_BANISHED,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--banish
function scard.banfilter(c,pwr)
	return c:IsFaceup() and c:IsPowerBelow(pwr) and c:KJIsBanishable()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local pwr=e:GetHandler():GetPower()
	if chkc then return chkc:IsLocation(LOCATION_BZONE) and chkc:IsControler(1-tp) and scard.banfilter(chkc,pwr) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISH)
	Duel.SelectTarget(tp,scard.banfilter,tp,0,LOCATION_BZONE,1,1,nil,pwr)
end
scard.op1=aux.TargetCardsOperation(Duel.KJBanish,REASON_EFFECT)
