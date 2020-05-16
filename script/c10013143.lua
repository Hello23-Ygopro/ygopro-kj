--Sigil of Primacy
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--get ability
function scard.cfilter(c)
	return c:IsFaceup() and c:IsEvolution()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
	local tc=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,1,1,nil):GetFirst()
	if not tc then return end
	Duel.HintSelection(Group.FromCards(tc))
	local c=e:GetHandler()
	if Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_BZONE,0,1,nil) then
		--power up
		aux.AddTempEffectUpdatePower(c,tc,2,5000)
		--break extra shield
		aux.AddTempEffectCustom(c,tc,3,EFFECT_BREAK_EXTRA_SHIELD)
	else
		--power up
		aux.AddTempEffectUpdatePower(c,tc,1,3000)
	end
end
