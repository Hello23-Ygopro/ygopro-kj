--Return from Beyond
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--to battle zone
	aux.AddSpellCastEffect(c,0,nil,aux.SendtoBZoneOperation(PLAYER_SELF,aux.KJDPileFilter(scard.tbfilter),LOCATION_DPILE,0,1))
end
--to battle zone
function scard.tbfilter(c)
	return c:IsCreature() and not c:IsEvolution() and c:IsManaCostBelow(4)
end
