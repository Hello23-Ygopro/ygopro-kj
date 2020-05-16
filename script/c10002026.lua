--Ghost Spy
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SPECTER)
	--creature
	aux.EnableCreatureAttribute(c)
	--discard
	aux.AddSingleTriggerEffect(c,0,EVENT_BANISHED,nil,nil,scard.op1)
end
--discard
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardHand(1-tp,aux.TRUE,1,1,REASON_EFFECT)
	if Duel.IsPlayerCanDraw(tp,1) and Duel.SelectYesNo(tp,YESNOMSG_DRAW) then
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
