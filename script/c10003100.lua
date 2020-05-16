--Badlands Lizard
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DUNE_GECKO)
	--creature
	aux.EnableCreatureAttribute(c)
	--powerful attack
	aux.EnablePowerfulAttack(c,1000)
	--must attack
	aux.EnableEffectCustom(c,EFFECT_MUST_ATTACK)
end
