--General Marnik
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ENFORCER,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter,scard.evofilter)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--unleash (confirm deck - cast for free or to battle zone)
	aux.EnableUnleash(c,0,scard.tg1,scard.op1)
end
--vortex evolution
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATIONS_LN)
--unleash (confirm deck - cast for free or to battle zone)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.KJDPileFilter(Card.IsSpell),tp,LOCATION_DPILE,0,1,nil)
		or Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function scard.tbfilter(c,e,tp)
	return c:IsCreature() and not c:IsEvolution() and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local uc=Duel.GetUnleashCard(c)
	local g1=Duel.GetMatchingGroup(aux.KJDPileFilter(Card.IsSpell),tp,LOCATION_DPILE,0,nil)
	if uc:IsCivilization(CIVILIZATION_LIGHT) and g1:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CASTFREE)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.CastFree(sg1)
		--redirect (to deck)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_TO_DPILE_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(LOCATION_DECKBOT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TODECK)
		sg1:GetFirst():RegisterEffect(e1,true)
	end
	local g2=Duel.GetMatchingGroup(scard.tbfilter,tp,LOCATION_DECK,0,nil,e,tp)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if uc:IsCivilization(CIVILIZATION_NATURE) and ct>0 then
		local seq=-1
		local tbcard=nil
		for tc in aux.Next(g2) do
			if tc:GetSequence()>seq then
				seq=tc:GetSequence()
				tbcard=tc
			end
		end
		if seq==-1 then
			Duel.ConfirmDecktop(tp,ct)
			Duel.ShuffleDeck(tp)
			return
		end
		Duel.ConfirmDecktop(tp,ct-seq)
		if tbcard:IsAbleToBZone(e,0,tp,false,false) then
			Duel.DisableShuffleCheck()
			if ct-seq==1 then Duel.SendtoBZone(tbcard,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
			else
				Duel.SendtoBZoneStep(tbcard,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
				Duel.ShuffleDeck(tp)
				Duel.SendtoBZoneComplete()
			end
		else Duel.ShuffleDeck(tp) end
	end
end
--[[
	References
	* Monster Gate
	https://github.com/Fluorohydride/ygopro-scripts/blob/6418030/c43040603.lua#L26
]]
