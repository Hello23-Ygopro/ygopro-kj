--Spellsworn Paladin
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ENFORCER,RACE_AQUAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter,scard.evofilter)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--unleash (return or cast for free)
	aux.EnableUnleash(c,0,scard.tg1,scard.op1)
end
--vortex evolution
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATIONS_LW)
--unleash (return or cast for free)
function scard.thfilter(c)
	return c:IsSpell() and c:IsAbleToHand()
end
function scard.castfilter(c)
	return c:IsSpell() and c:IsManaCostBelow(7)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.KJDPileFilter(scard.thfilter),tp,LOCATION_DPILE,0,1,nil)
		or Duel.IsExistingMatchingCard(scard.castfilter,tp,LOCATION_HAND,0,1,nil) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local uc=Duel.GetUnleashCard(e:GetHandler())
	local g1=Duel.GetMatchingGroup(aux.KJDPileFilter(scard.thfilter),tp,LOCATION_DPILE,0,nil)
	if uc:IsCivilization(CIVILIZATION_LIGHT) and g1:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.SendtoHand(sg1,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg1)
	end
	local g2=Duel.GetMatchingGroup(scard.castfilter,tp,LOCATION_HAND,0,nil)
	if uc:IsCivilization(CIVILIZATION_WATER) and g2:GetCount()>0 then
		local sg2=g2:Select(tp,0,1,nil)
		if sg2:GetCount()>0 then
			Duel.CastFree(sg2)
		end
	end
end
