--Mad Molder
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TARBORG)
	--creature
	aux.EnableCreatureAttribute(c)
end
