--Ensnare
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--to mana zone
	aux.AddSpellCastEffect(c,0,nil,aux.SendtoMZoneOperation(PLAYER_OPPO,scard.tmfilter,0,LOCATION_BZONE,1))
end
--to mana zone
function scard.tmfilter(c)
	return c:IsFaceup() and c:IsUntapped()
end
