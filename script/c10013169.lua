--Boulderfist the Pulverizer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TREE_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_NATURE))
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
	--unleash (to mana zone)
	aux.EnableUnleash(c,0,scard.tg1,scard.op1)
end
--unleash (to mana zone)
function scard.tmfilter(c,pwr)
	return c:IsFaceup() and c:IsPowerBelow(pwr) and c:IsAbleToMZone()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local uc=Duel.GetUnleashCard(e:GetHandler())
	local pwr=uc:GetPower()
	if chk==0 then return Duel.IsExistingMatchingCard(scard.tmfilter,tp,0,LOCATION_BZONE,1,nil,pwr) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local uc=Duel.GetUnleashCard(e:GetHandler())
	local pwr=uc:GetPower()
	local g=Duel.GetMatchingGroup(scard.tmfilter,tp,0,LOCATION_BZONE,nil,pwr)
	Duel.SendtoMZone(g,POS_FACEUP_UNTAPPED,REASON_EFFECT)
end
