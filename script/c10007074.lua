--Memory Keeper
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STORM_PATROL,RACE_CYBER_VIRUS)
	--creature
	aux.EnableCreatureAttribute(c)
end
