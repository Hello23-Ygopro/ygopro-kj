--Angler Cluster
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_UNDERTOW_ENGINE)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--guard
	aux.EnableGuard(c)
end
