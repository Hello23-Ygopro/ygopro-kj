--Haunted Mech
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SPECTER,RACE_STOMPER)
	--creature
	aux.EnableCreatureAttribute(c)
end
