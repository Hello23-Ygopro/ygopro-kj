--Glare of Sanction
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--tap
	aux.AddSpellCastEffect(c,0,nil,aux.TapOperation(nil,scard.posfilter,0,LOCATION_BZONE))
end
--tap
function scard.posfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(2000)
end
