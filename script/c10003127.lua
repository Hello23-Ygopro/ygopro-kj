--Snaptongue Lizard
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DUNE_GECKO)
	--creature
	aux.EnableCreatureAttribute(c)
end
