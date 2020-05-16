--Wandering Brain-Eater
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ZOMBIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--guard
	aux.EnableGuard(c)
	--enter tapped
	aux.EnableEffectCustom(c,EFFECT_ENTER_BZONE_TAPPED)
end
