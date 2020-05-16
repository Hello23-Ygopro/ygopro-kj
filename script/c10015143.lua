--Ritual of Challenge
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
function scard.batfilter(c,e)
	return c:IsFaceup() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
	local tc1=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,1,1,nil):GetFirst()
	if not tc1 then return end
	Duel.HintSelection(Group.FromCards(tc1))
	--power up
	aux.AddTempEffectUpdatePower(e:GetHandler(),tc1,1,3000)
	--do battle
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local tc2=Duel.SelectMatchingCard(tp,scard.batfilter,tp,0,LOCATION_BZONE,1,1,nil,e):GetFirst()
	if not tc1 or not tc1:IsFaceup() or not tc2 then return end
	Duel.SetTargetCard(tc2)
	Duel.DoBattle(tc1,tc2)
end
