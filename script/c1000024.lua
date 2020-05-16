--Grybolos the Gatherer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_AQUAN,RACE_TARBORG)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to discard pile, draw
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--to discard pile, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc1=Duel.GetDecktopGroup(tp,1):GetFirst()
	local tc2=Duel.GetDecktopGroup(1-tp,1):GetFirst()
	local dg1=Group.CreateGroup()
	local dg2=Group.CreateGroup()
	if tc1 then
		Duel.DisableShuffleCheck()
		Duel.KJSendtoDPile(tc1,REASON_EFFECT)
		dg1:AddCard(tc1)
	end
	if tc2 then
		Duel.DisableShuffleCheck()
		Duel.KJSendtoDPile(tc2,REASON_EFFECT)
		dg2:AddCard(tc2)
	end
	local dc1=dg1:GetFirst()
	local dc2=dg2:GetFirst()
	local ct=0
	if dc1 and dc1:IsSpell() then ct=ct+1 end
	if dc2 and dc2:IsSpell() then ct=ct+1 end
	if ct>0 and Duel.IsPlayerCanDraw(tp,1) and Duel.SelectYesNo(tp,YESNOMSG_DRAW) then
		Duel.Draw(tp,ct,REASON_EFFECT)
	end
end
