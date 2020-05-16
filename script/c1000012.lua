--Sparkblade Protector
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ENFORCER)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_ENFORCER))
	--blocker
	aux.EnableBlocker(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--get ability
	aux.AddTriggerEffect(c,0,EVENT_BANISHED,nil,nil,scard.op1,nil,scard.con1)
end
--get ability
scard.con1=aux.AND(aux.LeaveBZoneCondition(),aux.TurnPlayerCondition(PLAYER_OPPO))
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	if g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		for i=1,eg:GetCount() do
			--power up
			aux.AddTempEffectUpdatePower(e:GetHandler(),tc,1,2000)
		end
	end
end
