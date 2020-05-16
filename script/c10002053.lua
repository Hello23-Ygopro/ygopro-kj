--Splinterclaw Wasp
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MEGABUG)
	--creature
	aux.EnableCreatureAttribute(c)
	--powerful attack
	aux.EnablePowerfulAttack(c,4000)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
end
