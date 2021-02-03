--Corvus Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CELESTIAL_DRAGON,RACE_TERROR_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_CELESTIAL_DRAGON,RACE_TERROR_DRAGON))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--banish or to shield zone
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--banish or to shield zone
function scard.banfilter(c,e)
	return c:IsFaceup() and c:IsTapped() and c:KJIsBanishable() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetShieldCount(tp)
	local ct2=Duel.GetShieldCount(1-tp)
	if ct1>=ct2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISH)
		local g=Duel.SelectMatchingCard(tp,scard.banfilter,tp,0,LOCATION_BZONE,1,1,nil,e)
		if g:GetCount()==0 then return end
		Duel.SetTargetCard(g)
		Duel.KJBanish(g,REASON_EFFECT)
	elseif ct1<ct2 then
		if Duel.IsPlayerCanSendDecktoSZone(tp,1) and Duel.SelectYesNo(tp,YESNOMSG_TOSZONE) then
			Duel.SendDecktoSZone(tp,1)
		end
	end
end
