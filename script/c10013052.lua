--Steadfast Vorwhal
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LEVIATHAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--powerful block
	aux.EnablePowerfulBlock(c,2000)
	--guard
	aux.EnableGuard(c)
end
