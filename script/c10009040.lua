--Wild Growth
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--to mana zone
	aux.AddSpellCastEffect(c,0,nil,aux.SendtoMZoneOperation(PLAYER_SELF,nil,LOCATION_HAND,0,0,2))
end
