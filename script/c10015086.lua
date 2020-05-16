--Soul Reflection
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--confirm deck (get ability, to discard pile)
	aux.AddSpellCastEffect(c,0,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--confirm deck (get ability, to discard pile)
function scard.powfilter(c,e)
	return c:IsFaceup() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	Duel.ConfirmDecktop(tp,3)
	local g1=Duel.GetDecktopGroup(tp,3)
	local g2=Duel.GetMatchingGroup(scard.powfilter,tp,0,LOCATION_BZONE,nil,e)
	if g1:IsExists(Card.IsCreature,1,nil) and g2:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
		local sg1=g1:FilterSelect(tp,Card.IsCreature,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local sg2=g2:Select(tp,1,1,nil)
		Duel.SetTargetCard(sg2)
		--power down
		aux.AddTempEffectUpdatePower(e:GetHandler(),sg2:GetFirst(),1,-sg1:GetFirst():GetPower())
	end
	Duel.DisableShuffleCheck()
	Duel.KJSendtoDPile(g1,REASON_EFFECT)
end
