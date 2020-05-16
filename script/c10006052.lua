--Sok'ran the Untamed
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_EARTHSTRIKE_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRaceCategory,RACECAT_DRAGON))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--break
	aux.AddTriggerEffectWinBattle(c,0,nil,nil,scard.op1,nil,scard.con1)
end
--break
scard.con1=aux.BattleWinCondition(aux.FilterBoolFunction(Card.IsRaceCategory,RACECAT_DRAGON))
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.BreakShield(tp,1-tp,1,1,eg:GetFirst(),REASON_EFFECT)
end
