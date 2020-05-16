--Mind Core
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--draw
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--draw
function scard.cfilter(c)
	return c:IsFaceup() and c:IsEvolution()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	if Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_BZONE,0,1,nil) then
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end
