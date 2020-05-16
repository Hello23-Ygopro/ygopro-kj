--Blastforge Marauder
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DRAKON)
	--creature
	aux.EnableCreatureAttribute(c)
	--fast attack
	aux.EnableEffectCustom(c,EFFECT_FAST_ATTACK)
	--powerful attack
	aux.EnablePowerfulAttack(c,6000)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
