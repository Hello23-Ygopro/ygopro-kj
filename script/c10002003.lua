--Keeper of Clouds
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STORM_PATROL)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--skirmisher
	aux.EnableSkirmisher(c)
end
