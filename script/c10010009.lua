--Engulf
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--return
	aux.AddSpellCastEffect(c,0,nil,aux.SendtoHandOperation(PLAYER_OPPO,scard.retfilter,0,LOCATION_BZONE,1))
end
--return
function scard.retfilter(c)
	return c:IsFaceup() and c:IsUntapped()
end
