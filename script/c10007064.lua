--Reinforce
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--confirm deck (to hand)
	aux.AddSpellCastEffect(c,0,nil,aux.DecktopSendtoHandOperation(PLAYER_SELF,Card.IsCreature,3,0,3,SEQ_DECK_BOTTOM,nil,true))
end
