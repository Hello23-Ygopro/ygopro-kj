--Master Trader Cephelia
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,aux.DrawTarget(PLAYER_SELF),scard.op1,nil,scard.con1)
end
--draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	local ct2=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	if ct2>ct1 then
		Duel.Draw(tp,ct2-ct1,REASON_EFFECT)
	end
	if Duel.IsPlayerCanDraw(tp,1) and Duel.SelectYesNo(tp,YESNOMSG_DRAW) then
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
--[[
	Rulings
	Q: If my opponent has fewer cards in hand than I do, or we have the same number, can I still draw a card?
		A: Yes.
	https://kaijudo.fandom.com/wiki/Master_Trader_Cephelia/Rulings
]]
