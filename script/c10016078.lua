--Apocalypse Knight
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SHADOW_CHAMPION,RACE_COLOSSUS)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter,scard.evofilter)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--unleash (get ability)
	aux.EnableUnleash(c,0,nil,scard.op1)
end
--vortex evolution
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATIONS_DN)
--unleash (get ability)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local uc=Duel.GetUnleashCard(c)
	local g1=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_BZONE,nil)
	if uc:IsCivilization(CIVILIZATION_DARKNESS) and g1:GetCount()>0 then
		for tc1 in aux.Next(g1) do
			--power down
			aux.AddTempEffectUpdatePower(c,tc1,1,-2000)
		end
	end
	local g2=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	if uc:IsCivilization(CIVILIZATION_NATURE) and g2:GetCount()>0 then
		for tc2 in aux.Next(g2) do
			--power up
			aux.AddTempEffectUpdatePower(c,tc2,2,2000)
			--cannot be blocked
			aux.AddTempEffectCannotBeBlocked(c,tc2,3,aux.CannotBeBlockedLessPowerValue)
		end
	end
end
