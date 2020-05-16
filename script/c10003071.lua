--Dark Return
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--return
	aux.AddSpellCastEffect(c,0,nil,aux.SendtoHandOperation(PLAYER_SELF,aux.KJDPileFilter(Card.IsCreature),LOCATION_DPILE,0,1))
end
