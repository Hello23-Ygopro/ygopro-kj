--Logic Cube
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--to hand
	aux.AddSpellCastEffect(c,0,nil,aux.DecktopSendtoHandOperation(PLAYER_SELF,Card.IsSpell,5,0,1,SEQ_DECK_BOTTOM,nil,true))
end
