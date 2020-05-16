--Bolt-Hawk
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MECHA_THUNDER)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--skirmisher
	aux.EnableSkirmisher(c)
end
