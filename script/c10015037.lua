--Deep-Currents Drifter
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_VIRUS)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--powerful block
	aux.EnablePowerfulBlock(c,3000)
	--guard
	aux.EnableGuard(c)
end
