--Absolute Darkness
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_BZONE,nil)
	if g:GetCount()==0 then return end
	local c=e:GetHandler()
	for tc in aux.Next(g) do
		--power down
		aux.AddTempEffectUpdatePower(c,tc,1,-6000)
		--cannot block
		aux.AddTempEffectCustom(c,tc,2,EFFECT_CANNOT_BLOCK)
	end
end
