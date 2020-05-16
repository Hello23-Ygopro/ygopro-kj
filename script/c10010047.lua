--Dawnblaze Patrol
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STORM_PATROL,RACE_STOMPER)
	--creature
	aux.EnableCreatureAttribute(c)
end
