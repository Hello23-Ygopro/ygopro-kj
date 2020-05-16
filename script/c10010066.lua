--Telanar, the Stormer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TSUNAMI_DRAGON,RACE_EARTHSTRIKE_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_TSUNAMI_DRAGON,RACE_EARTHSTRIKE_DRAGON))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--draw
	aux.AddTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,2),nil,scard.con1)
end
--draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc:IsControler(tp) and tc:IsPowerAbove(6000)
end
