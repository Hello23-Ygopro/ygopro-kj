--Sprite's Gift
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--return
	aux.AddSpellCastEffect(c,0,nil,aux.SendtoHandOperation(PLAYER_SELF,aux.ManaZoneFilter(),LOCATION_MZONE,0,1))
end
