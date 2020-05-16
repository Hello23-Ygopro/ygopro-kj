--Veil Stalker
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION,RACE_SHADOW_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--discard, draw
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--discard, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.RandomDiscardHand(1-tp,1,REASON_EFFECT)==0 then return end
	local tc=Duel.GetOperatedGroup():GetFirst()
	if tc:IsManaCostBelow(3) and Duel.IsPlayerCanDraw(tp,1) and Duel.SelectYesNo(tp,YESNOMSG_DRAW) then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
