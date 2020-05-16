--Waterway Watcher
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_UNDERTOW_ENGINE)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--powerful block
	aux.EnablePowerfulBlock(c,2000)
	--guard
	aux.EnableGuard(c)
end
