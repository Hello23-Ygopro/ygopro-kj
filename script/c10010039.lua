--Reverberate
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--draw
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,Duel.GetShieldCount(tp),REASON_EFFECT)
end
