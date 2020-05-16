--Hive Marshal Golian
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MEGABUG)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_NATURE))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--unleash (get ability)
	aux.EnableUnleash(c,0,aux.CheckCardFunction(Card.IsFaceup,LOCATION_BZONE,0,c),scard.op1)
end
--unleash (get ability)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,c)
	if g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		--power up
		aux.AddTempEffectUpdatePower(c,tc,1,3000)
		--cannot be blocked
		aux.AddTempEffectCannotBeBlocked(c,tc,2,aux.CannotBeBlockedLessPowerValue)
	end
end
