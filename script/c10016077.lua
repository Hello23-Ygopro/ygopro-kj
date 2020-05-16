--Furnace Crawler
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ROT_WORM,RACE_STOMPER)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter,scard.evofilter)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--unleash (get ability or banish)
	aux.EnableUnleash(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--vortex evolution
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATIONS_DF)
--unleash (get ability or banish)
function scard.banfilter1(c)
	return c:IsFaceup() and c:IsPowerBelow(5000) and c:KJIsBanishable()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_BZONE,1,nil)
		or Duel.IsExistingTarget(scard.banfilter1,tp,0,LOCATION_BZONE,1,nil) end
end
function scard.powfilter(c,e)
	return c:IsFaceup() and c:IsCanBeEffectTarget(e)
end
function scard.banfilter2(c,e)
	return scard.banfilter1(c) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local uc=Duel.GetUnleashCard(c)
	local g1=Duel.GetMatchingGroup(scard.powfilter,tp,0,LOCATION_BZONE,nil,e)
	if uc:IsCivilization(CIVILIZATION_DARKNESS) and g1:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.SetTargetCard(sg1)
		--power down
		aux.AddTempEffectUpdatePower(c,sg1:GetFirst(),1,-4000)
	end
	local g2=Duel.GetMatchingGroup(scard.banfilter2,tp,0,LOCATION_BZONE,nil,e)
	if uc:IsCivilization(CIVILIZATION_FIRE) and g2:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISH)
		local sg2=g2:Select(tp,1,1,nil)
		Duel.SetTargetCard(sg2)
		Duel.KJBanish(sg2,REASON_EFFECT)
	end
end
