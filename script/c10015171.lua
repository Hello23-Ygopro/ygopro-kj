--Dragon Engine Glu-urrgle
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	aux.AddNameCategory(c,NAMECAT_GLUURRGLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter,scard.evofilter)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--draw
	aux.AddTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,1),nil,scard.con1)
	--get ability
	aux.AddTriggerEffect(c,1,EVENT_DRAW,nil,nil,scard.op1,nil,aux.EventPlayerCondition(PLAYER_SELF))
end
--vortex evolution
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATIONS_WF)
--draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(tp)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,eg:GetCount(),eg:GetCount(),nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	local reset_count=(Duel.GetTurnPlayer()==tp and 2 or 1)
	for tc in aux.Next(g) do
		--banish replace (return)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(sid,2))
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EFFECT_BANISH_REPLACE)
		e1:SetRange(LOCATION_BZONE)
		e1:SetTarget(aux.SingleReplaceBanishTarget(Card.IsAbleToHand))
		e1:SetOperation(aux.SingleReplaceBanishOperation(Duel.SendtoHand,PLAYER_OWNER,REASON_EFFECT+REASON_REPLACE))
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DRAW,reset_count)
		tc:RegisterEffect(e1)
	end
end
