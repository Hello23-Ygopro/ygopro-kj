--Mind Censor
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_VIRUS,RACE_SHADOW_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--discard
	aux.AddTriggerEffect(c,0,EVENT_LEAVE_BZONE,nil,nil,scard.op1,nil,aux.LeaveBZoneCondition(PLAYER_OPPO))
end
--discard
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	for i=1,eg:GetCount() do
		Duel.DiscardHand(1-tp,aux.TRUE,1,1,REASON_EFFECT)
	end
end
