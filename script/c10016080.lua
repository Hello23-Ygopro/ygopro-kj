--Magmablast Mammoth
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STOMPER,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter,scard.evofilter)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--unleash (get ability or do battle)
	aux.EnableUnleash(c,0,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--vortex evolution
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATIONS_FN)
--unleash (get ability or do battle)
function scard.batfilter(c,e)
	return c:IsFaceup() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local uc=Duel.GetUnleashCard(c)
	local g1=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	if uc:IsCivilization(CIVILIZATION_FIRE) and g1:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.HintSelection(sg1)
		--power up
		aux.AddTempEffectUpdatePower(c,sg1:GetFirst(),1,7000,nil,nil,aux.SelfBattlingCondition)
	end
	local g2=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	local g3=Duel.GetMatchingGroup(scard.batfilter,tp,0,LOCATION_BZONE,nil,e)
	if uc:IsCivilization(CIVILIZATION_NATURE) and g2:GetCount()>0 and g3:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
		local sg2=g2:Select(tp,1,1,nil)
		Duel.HintSelection(sg2)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local sg3=g3:Select(tp,1,1,nil)
		Duel.SetTargetCard(sg3)
		Duel.DoBattle(sg2:GetFirst(),sg3:GetFirst())
	end
end
