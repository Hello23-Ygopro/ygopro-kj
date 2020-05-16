--Ashen Tribute
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--banish
	aux.AddSpellCastEffect(c,0,nil,aux.BanishOperation(PLAYER_OPPO,scard.banfilter,0,LOCATION_BZONE,1))
end
--banish
function scard.banfilter(c)
	return c:IsFaceup() and c:IsHasEffect(EFFECT_BLOCKER)
end
