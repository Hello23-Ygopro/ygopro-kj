--Sky-Ring Captain
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--untap
	aux.AddTriggerEffect(c,0,EVENT_PHASE+PHASE_END,nil,nil,scard.op1,nil,scard.con1)
end
--untap
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToUntap()
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.GetTurnPlayer()==tp
		and c:IsFaceup() and c:IsTapped() and Duel.IsExistingMatchingCard(scard.posfilter,tp,LOCATION_BZONE,0,1,c)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_UNTAP)
	local g=Duel.SelectMatchingCard(tp,scard.posfilter,tp,LOCATION_BZONE,0,1,1,e:GetHandler())
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.Untap(g,REASON_EFFECT)
end
