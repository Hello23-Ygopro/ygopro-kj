--Shadow Strike
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--get ability
function scard.powfilter(c,e)
	return c:IsFaceup() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
	local g1=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,1,1,nil)
	if g1:GetCount()==0 then return end
	Duel.HintSelection(g1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g2=Duel.SelectMatchingCard(tp,scard.powfilter,tp,0,LOCATION_BZONE,1,1,nil,e)
	if g2:GetCount()==0 then return end
	Duel.SetTargetCard(g2)
	--power down
	aux.AddTempEffectUpdatePower(e:GetHandler(),g2:GetFirst(),1,-g1:GetFirst():GetPower())
end
