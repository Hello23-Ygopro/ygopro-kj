--Gregoria the Malevolent
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DARK_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--confirm hand (discard)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--confirm hand (discard)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	scard.discard(tp)
	scard.discard(1-tp)
end
function scard.discard(tp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if g:GetCount()==0 then return end
	Duel.ConfirmCards(1-tp,g)
	local sg=g:Filter(Card.IsSpell,nil)
	Duel.KJSendtoDPile(sg,REASON_EFFECT+REASON_DISCARD)
	Duel.ShuffleHand(tp)
end
--[[
	References
		1. Morphing Jar #2
		https://github.com/Fluorohydride/ygopro-scripts/blob/b2c6aa3/c79106360.lua#L46
]]
