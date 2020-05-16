--Eye of the Tides
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_VIRUS)
	--creature
	aux.EnableCreatureAttribute(c)
end
