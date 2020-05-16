--Barrage
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--banish
	aux.AddSpellCastEffect(c,0,nil,aux.BanishOperation(nil,scard.banfilter,0,LOCATION_BZONE))
end
--banish
function scard.banfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(2000)
end
