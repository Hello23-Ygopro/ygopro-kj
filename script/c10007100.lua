--Lizard-Skin Puppet
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_EVIL_TOY,RACE_DUNE_GECKO)
	--creature
	aux.EnableCreatureAttribute(c)
	--slayer
	aux.EnableSlayer(c)
	--must attack
	aux.EnableEffectCustom(c,EFFECT_MUST_ATTACK)
end
