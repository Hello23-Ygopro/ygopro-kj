--The Reviled
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CORRUPTED,RACE_CHIMERA)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_CORRUPTED,RACE_CHIMERA))
	--cost down
	aux.EnableUpdatePlayCost(c,scard.val1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--return
	aux.AddTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,scard.op1,nil,scard.con1)
end
--cost down
function scard.val1(e,c)
	return Duel.GetMatchingGroupCount(aux.KJDPileFilter(Card.KJIsRace),c:GetControler(),LOCATION_DPILE,0,nil,RACE_CORRUPTED)*-1
end
--return
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc:IsControler(tp) and tc:KJIsRace(RACE_CORRUPTED)
end
scard.op1=aux.SendtoHandOperation(PLAYER_SELF,aux.KJDPileFilter(Card.IsCreature),LOCATION_DPILE,0,1)
