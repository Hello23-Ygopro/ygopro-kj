--Vectro Scout
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_INVADER)
	--creature
	aux.EnableCreatureAttribute(c)
end
