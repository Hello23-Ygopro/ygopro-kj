--Glorious Inferno Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter,scard.evofilter)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
	--unleash (get ability or banish)
	aux.EnableUnleash(c,0,nil,scard.op1)
end
--vortex evolution
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATIONS_LF)
--unleash (get ability or banish)
function scard.banfilter(c)
	return c:IsFaceup() and c:IsHasEffect(EFFECT_BLOCKER) and c:KJIsBanishable()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local uc=Duel.GetUnleashCard(c)
	local g1=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	if uc:IsCivilization(CIVILIZATION_LIGHT) and g1:GetCount()>0 then
		for tc in aux.Next(g1) do
			--power up
			aux.AddTempEffectUpdatePower(c,tc,2,3000)
			--untap
			local e1=Effect.CreateEffect(c)
			e1:SetDescription(aux.Stringid(sid,1))
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_PHASE+PHASE_END)
			e1:SetRange(LOCATION_BZONE)
			e1:SetCountLimit(1)
			e1:SetOperation(scard.op2)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
		end
	end
	local g2=Duel.GetMatchingGroup(scard.banfilter,tp,0,LOCATION_BZONE,nil)
	if uc:IsCivilization(CIVILIZATION_FIRE) then
		Duel.KJBanish(g2,REASON_EFFECT)
	end
end
--untap
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsAbleToUntap() then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Untap(c,REASON_EFFECT)
end
