--Veil Rift
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--confirm deck (to hand)
	aux.AddSpellCastEffect(c,0,nil,aux.DecktopSendtoHandOperation(PLAYER_SELF,scard.thfilter,3,0,3,SEQ_DECK_BOTTOM,nil,true))
end
--confirm deck (to hand)
function scard.thfilter(c)
	return c:IsPowerAbove(6000)
end
