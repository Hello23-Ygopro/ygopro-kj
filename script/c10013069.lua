--Forsaken Puppet
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_EVIL_TOY)
	--creature
	aux.EnableCreatureAttribute(c)
	--enter tapped
	aux.EnableEffectCustom(c,EFFECT_ENTER_BZONE_TAPPED)
end
