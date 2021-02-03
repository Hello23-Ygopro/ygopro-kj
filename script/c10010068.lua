--Flamespine Ravager
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SPECTER,RACE_DRAKON)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_SPECTER,RACE_DRAKON))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to discard pile, banish
	aux.AddTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to discard pile, banish
function scard.banfilter(c,e,pwr)
	return c:IsFaceup() and c:GetPower()<pwr and c:KJIsBanishable() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.KJSendDecktoDPile(1-tp,1,REASON_EFFECT)==0 then return end
	local tc=Duel.GetOperatedGroup():GetFirst()
	if not tc:IsCreature() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISH)
	local g=Duel.SelectMatchingCard(tp,scard.banfilter,tp,0,LOCATION_BZONE,1,1,e,tc:GetPower())
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.KJBanish(g,REASON_EFFECT)
end
