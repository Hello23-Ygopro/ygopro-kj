--Stormspark Blast
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--tap
	aux.AddSpellCastEffect(c,0,nil,aux.TapOperation(nil,Card.IsFaceup,0,LOCATION_BZONE))
end
