--Spy Mission (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--draw
	aux.AddSpellCastEffect(c,0,nil,aux.DrawOperation(PLAYER_SELF,2))
end
