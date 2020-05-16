--Ragestrike Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--cost down
	aux.EnableUpdatePlayCost(c,-4,scard.con1)
end
--cost down
function scard.con1(e)
	return Duel.GetShieldCount(1-e:GetHandlerPlayer())<=3
end
