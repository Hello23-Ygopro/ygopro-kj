--Blaze Belcher (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BURN_BELLY)
	--creature
	aux.EnableCreatureAttribute(c)
	--must attack
	aux.EnableEffectCustom(c,EFFECT_MUST_ATTACK)
end
