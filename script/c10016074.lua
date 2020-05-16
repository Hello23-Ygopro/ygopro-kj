--Nivarex the Unquenchable
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LEVIATHAN,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
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
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATIONS_WF)
--unleash (get ability)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	if g:GetCount()==0 then return end
	local c=e:GetHandler()
	local uc=Duel.GetUnleashCard(c)
	if uc:IsCivilization(CIVILIZATION_WATER) then
		for tc in aux.Next(g) do
			--cannot be blocked
			aux.AddTempEffectCannotBeBlocked(c,tc,1)
		end
	end
	if uc:IsCivilization(CIVILIZATION_FIRE) then
		for tc in aux.Next(g) do
			--powerful attack
			aux.AddTempEffectPowerfulAttack(c,tc,2,5000)
			--break extra shield
			aux.AddTempEffectCustom(c,tc,3,EFFECT_BREAK_EXTRA_SHIELD)
		end
	end
end
