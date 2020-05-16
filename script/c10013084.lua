--Shanok, the Soul Harvester
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SPECTER)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_DARKNESS))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--unleash (get ability)
	aux.EnableUnleash(c,0,aux.CheckCardFunction(Card.IsFaceup,0,LOCATION_BZONE),scard.op1)
end
--unleash (get ability)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_BZONE,nil)
	if g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		--power down
		aux.AddTempEffectUpdatePower(e:GetHandler(),tc,1,-2000)
	end
end
