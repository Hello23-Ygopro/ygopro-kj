--Manabind
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to mana zone
	aux.AddSpellCastEffect(c,0,nil,aux.SendtoMZoneOperation(PLAYER_SELF,Card.IsFaceup,LOCATION_BZONE,0,1))
end
