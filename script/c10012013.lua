--Hypergrid Hacker
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	--banish replace (return)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_BANISH_REPLACE)
	e1:SetRange(LOCATION_BZONE)
	e1:SetTarget(aux.SingleReplaceBanishTarget(Card.IsAbleToHand))
	e1:SetOperation(aux.SingleReplaceBanishOperation(Duel.SendtoHand,PLAYER_OWNER,REASON_EFFECT+REASON_REPLACE))
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	g:GetFirst():RegisterEffect(e1)
end
