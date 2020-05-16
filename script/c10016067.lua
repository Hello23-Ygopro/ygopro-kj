--Alcadeus, Vengeance Archon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION,RACE_SHADOW_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter,scard.evofilter)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--unleash (tap or banish)
	aux.EnableUnleash(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--vortex evolution
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATIONS_LD)
--unleash (tap or banish)
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToTap()
end
function scard.banfilter1(c)
	return c:IsFaceup() and c:IsTapped() and c:KJIsBanishable()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.posfilter,tp,0,LOCATION_BZONE,1,nil)
		or Duel.IsExistingTarget(scard.banfilter1,tp,0,LOCATION_BZONE,1,nil) end
end
function scard.banfilter2(c,e)
	return scard.banfilter1(c) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local uc=Duel.GetUnleashCard(e:GetHandler())
	local g1=Duel.GetMatchingGroup(scard.posfilter,tp,0,LOCATION_BZONE,nil)
	if uc:IsCivilization(CIVILIZATION_LIGHT) then
		Duel.Tap(g1,REASON_EFFECT)
	end
	local g2=Duel.GetMatchingGroup(scard.banfilter2,tp,0,LOCATION_BZONE,nil,e)
	if uc:IsCivilization(CIVILIZATION_DARKNESS) and g2:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISH)
		local sg=g2:Select(tp,1,1,nil)
		Duel.SetTargetCard(sg)
		Duel.KJBanish(sg,REASON_EFFECT)
	end
end
