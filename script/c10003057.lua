--Predict
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--sort
	aux.AddSpellCastEffect(c,0,nil,aux.SortDecktopOperation(PLAYER_SELF,PLAYER_SELF,4))
end
