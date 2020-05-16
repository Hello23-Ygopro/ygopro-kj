--Captive Squill
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CORRUPTED,RACE_AQUAN)
	--creature
	aux.EnableCreatureAttribute(c)
end
