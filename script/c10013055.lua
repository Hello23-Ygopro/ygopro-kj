--Thought Collective
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--to hand
	aux.AddSpellCastEffect(c,0,nil,aux.DecktopSendtoHandOperation(PLAYER_SELF,nil,5,1,1,SEQ_DECK_BOTTOM))
end
