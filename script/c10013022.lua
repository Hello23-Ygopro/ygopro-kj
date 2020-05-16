--Safe Passage
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,0,2,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	for tc in aux.Next(g) do
		--cannot be blocked
		aux.AddTempEffectCannotBeBlocked(e:GetHandler(),tc,1)
	end
end
