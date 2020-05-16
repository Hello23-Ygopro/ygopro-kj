--Jetflame Bodyguard
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DRAKON)
	--creature
	aux.EnableCreatureAttribute(c)
	--skirmisher
	aux.EnableSkirmisher(c)
end
