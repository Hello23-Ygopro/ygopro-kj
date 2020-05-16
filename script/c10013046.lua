--Pincer-Fin
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TRENCH_HUNTER)
	--creature
	aux.EnableCreatureAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--blocker
	aux.EnableBlocker(c)
	--guard
	aux.EnableGuard(c)
end
