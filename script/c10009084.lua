--Forgelord Vesuvius
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BLAZE_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--discard, draw
	aux.AddSingleTriggerEffectWinBattle(c,0,true,scard.tg1,scard.op1)
end
--discard, draw
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_HAND,0,1,nil)
		or Duel.IsPlayerCanDraw(tp,1) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.KJSendtoDPile(g,REASON_EFFECT+REASON_DISCARD)
	Duel.Draw(tp,5,REASON_EFFECT)
end
--[[
	Rulings
	Q: Can I use "Rekindle" if I have no cards in my hand?
		A: Yes. You won't discard any cards, but you'll still get to draw 5 cards.
	https://kaijudo.fandom.com/wiki/Forgelord_Vesuvius/Rulings
]]
