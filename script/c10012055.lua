--Magmaclysm Rex
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ROCK_BRUTE,RACE_COLOSSUS)
	--creature
	aux.EnableCreatureAttribute(c)
	--powerful attack
	aux.EnablePowerfulAttack(c,7000)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
end
