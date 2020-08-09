--Ember Adept
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DRAKON)
	--creature
	aux.EnableCreatureAttribute(c)
	--protector
	aux.EnableProtector(c)
	--discard, draw
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,aux.CheckCardFunction(aux.TRUE,LOCATION_HAND,0),scard.op1)
end
--discard, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.DiscardHand(tp,aux.TRUE,1,1,REASON_EFFECT)>0 then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
--[[
	Rulings
	Q: If I don't have any cards in my hand, can I just draw a card?
		A: No.
	https://kaijudo.fandom.com/wiki/Mischievous_Fire-Chick/Rulings
]]
