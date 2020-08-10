--Gilaflame the Draconic
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON,RACE_DRAKON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter,scard.evofilter)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--return
	aux.AddTriggerEffect(c,0,EVENT_PHASE+PHASE_END,nil,scard.tg1,scard.op1,nil,aux.TurnPlayerCondition(PLAYER_SELF))
	--banish
	aux.AddSingleTriggerEffect(c,1,EVENT_ATTACK_ANNOUNCE,nil,nil,aux.BanishOperation(nil,scard.banfilter,0,LOCATION_BZONE))
end
--vortex evolution
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_FIRE)
--return
function scard.thfilter(c)
	return c:IsFaceup() and c:IsTapped() and c:IsAbleToHand()
end
scard.tg1=aux.CheckCardFunction(scard.thfilter,LOCATION_BZONE,0)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(scard.thfilter,tp,LOCATION_BZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_BZONE,0,1,ct,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
end
--banish
function scard.banfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(2000)
end
