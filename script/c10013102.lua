--Megacannon Renegade
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BERSERKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_FIRE))
	--unleash (get ability)
	aux.EnableUnleash(c,0,nil,scard.op1)
end
--unleash (get ability)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--power up
	aux.AddTempEffectUpdatePower(c,c,1,3000)
	--double breaker
	aux.AddTempEffectBreaker(c,c,2,EFFECT_DOUBLE_BREAKER)
end
