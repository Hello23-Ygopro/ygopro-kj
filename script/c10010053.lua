--Emergency Protocol
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--draw, break
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--draw, break
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.DrawUpTo(tp,2,REASON_EFFECT)
	Duel.BreakShield(tp,tp,0,2,nil,REASON_EFFECT)
end
