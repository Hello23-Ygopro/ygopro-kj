--Tendril Grasp
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--to mana zone
	aux.AddSpellCastEffect(c,0,nil,aux.SendtoMZoneOperation(nil,scard.tmfilter,LOCATION_BZONE,LOCATION_BZONE))
end
--to mana zone
function scard.tmfilter(c)
	return c:IsFaceup() and c:IsManaCostBelow(3)
end
