--Bristling Tatsurion
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON,RACE_BEAST_KIN)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	aux.AddNameCategory(c,NAMECAT_TATSURION)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_NATURE))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER,scard.con1)
	aux.AddEffectDescription(c,1,scard.con1)
	--cannot be attacked
	aux.EnableCannotBeAttacked(c,nil,nil,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf())
	--unleash (get ability)
	aux.EnableUnleash(c,0,nil,scard.op1)
end
--triple breaker
function scard.con1(e)
	return e:GetHandler():IsPowerAbove(12000)
end
--unleash (get ability)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	local ct=Duel.GetMatchingGroupCount(Card.IsFaceup,tp,LOCATION_BZONE,0,c)
	local reset_count=(Duel.GetTurnPlayer()==tp and 2 or 1)
	--power up
	aux.AddTempEffectUpdatePower(c,c,2,ct*3000,RESET_PHASE+PHASE_DRAW,reset_count)
end
