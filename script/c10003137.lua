--Carnivorous Dahlia
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TREE_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--skirmisher
	aux.EnableSkirmisher(c)
end
