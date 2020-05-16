--Smolderhorn
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ROCK_BRUTE,RACE_TUSKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--fast attack
	aux.EnableEffectCustom(c,EFFECT_FAST_ATTACK)
	--skirmisher
	aux.EnableSkirmisher(c)
end
