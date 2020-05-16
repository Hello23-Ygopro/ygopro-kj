--Bloated Gatekeeper
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SHADOW_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--guard
	aux.EnableGuard(c)
	--enter tapped
	aux.EnableEffectCustom(c,EFFECT_ENTER_BZONE_TAPPED)
end
