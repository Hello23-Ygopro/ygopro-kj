--Skrap Skull
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DREAD_MASK)
	--creature
	aux.EnableCreatureAttribute(c)
end
