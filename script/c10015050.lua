--Spy Tide
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--draw, discard
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--draw, discard
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Draw(tp,3,REASON_EFFECT)>0 then Duel.ShuffleHand(tp) end
	Duel.BreakEffect()
	Duel.DiscardHand(tp,aux.TRUE,2,2,REASON_EFFECT,e:GetHandler())
end
