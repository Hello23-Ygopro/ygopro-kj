--Hazard Crawler
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_EARTH_EATER)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot be attacked
	aux.EnableCannotBeAttacked(c)
	--cannot be blocked
	aux.EnableCannotBeBlocked(c)
end
