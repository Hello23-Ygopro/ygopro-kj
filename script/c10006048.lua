--Energize
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--to mana zone, get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--to mana zone, get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendDecktoptoMZone(tp,1,POS_FACEUP_UNTAPPED,REASON_EFFECT)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	if g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		--power up
		aux.AddTempEffectUpdatePower(e:GetHandler(),tc,1,1000)
	end
end
