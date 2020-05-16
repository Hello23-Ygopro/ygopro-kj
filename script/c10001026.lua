--Flametropus
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ROCK_BRUTE)
	--creature
	aux.EnableCreatureAttribute(c)
	--powerful attack
	aux.EnablePowerfulAttack(c,4000,scard.con1)
	aux.AddEffectDescription(c,0,scard.con1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER,scard.con1)
	aux.AddEffectDescription(c,1,scard.con1)
end
--powerful attack, double breaker
function scard.con1(e)
	return not Duel.IsExistingMatchingCard(Card.IsFaceup,e:GetHandlerPlayer(),LOCATION_BZONE,0,1,e:GetHandler())
end
