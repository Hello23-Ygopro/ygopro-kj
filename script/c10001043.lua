--Sprout
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--to mana zone
	aux.AddSpellCastEffect(c,0,nil,aux.DecktopSendtoMZoneOperation(PLAYER_SELF,1))
end
