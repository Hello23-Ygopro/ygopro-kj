--King Arboreus
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LEVIATHAN,RACE_COLOSSUS)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter,scard.evofilter)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--unleash (draw or to battle zone)
	aux.EnableUnleash(c,0,scard.tg1,scard.op1)
end
--vortex evolution
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATIONS_WN)
--unleash (draw or to battle zone)
function scard.tbfilter(c,e,tp)
	return c:IsCreature() and not c:IsEvolution() and c:IsManaCostBelow(6) and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		or Duel.IsExistingMatchingCard(scard.tbfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local uc=Duel.GetUnleashCard(e:GetHandler())
	if uc:IsCivilization(CIVILIZATION_WATER) then
		Duel.Draw(tp,2,REASON_EFFECT)
	end
	local g=Duel.GetMatchingGroup(scard.tbfilter,tp,LOCATION_HAND,0,nil,e,tp)
	if uc:IsCivilization(CIVILIZATION_NATURE) and g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
		local sg=g:Select(tp,0,1,nil)
		if sg:GetCount()>0 then
			Duel.SendtoBZone(sg,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
		end
	end
end
