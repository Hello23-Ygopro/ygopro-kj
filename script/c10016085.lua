--Ultimate Tatsurion
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON,RACE_BEAST_KIN)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	aux.AddNameCategory(c,NAMECAT_TATSURION)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter,scard.evofilter)
	--world breaker
	aux.EnableBreaker(c,EFFECT_WORLD_BREAKER)
	--get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--vortex evolution
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATIONS_FN)
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,c)
	if g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		--cannot be blocked
		aux.AddTempEffectCannotBeBlocked(c,tc,1,nil,scard.con1)
		--attack untapped
		aux.AddTempEffectCustom(c,tc,2,EFFECT_ATTACK_UNTAPPED)
	end
end
--cannot be blocked
function scard.con1(e)
	return Duel.GetAttacker()==e:GetHandler() and Duel.GetAttackTarget()~=nil
end
