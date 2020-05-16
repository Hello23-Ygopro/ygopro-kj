--Captain Snowbeard
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SHADOW_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to battle zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
	--draw
	aux.AddSingleTriggerEffect(c,1,EVENT_BANISHED,nil,nil,scard.op2)
	aux.AddTriggerEffect(c,1,EVENT_BANISHED,nil,nil,scard.op2,nil,aux.LeaveBZoneCondition())
end
--to battle zone
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	scard.tobattle(e,tp)
	scard.tobattle(e,1-tp)
end
function scard.tbfilter(c,e,tp)
	return c:IsCreature() and not c:IsEvolution() and c:IsManaCostBelow(3) and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.tobattle(e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
	local g=Duel.SelectMatchingCard(tp,aux.KJDPileFilter(scard.tbfilter),tp,LOCATION_DPILE,0,0,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SendtoBZone(g,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
	end
end
--draw
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	for tc in aux.Next(eg) do
		local p=tc:GetOwner()
		if Duel.IsPlayerCanDraw(p,1) and Duel.SelectYesNo(p,YESNOMSG_DRAW) then
			Duel.Draw(p,1,REASON_EFFECT)
		end
	end
end
