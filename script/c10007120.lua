--Tatsurion the Relentless
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON,RACE_BEAST_KIN)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	aux.AddNameCategory(c,NAMECAT_TATSURION)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionNameCategory,NAMECAT_TATSURION))
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
	--untap, break
	aux.AddSingleTriggerEffectWinBattle(c,0,nil,nil,scard.op1,nil,scard.con1)
end
--untap, break
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	return tc:GetPreviousPowerOnField()<=5000 and not tc:IsLocation(LOCATION_BZONE)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	Duel.Untap(c,REASON_EFFECT)
	Duel.BreakShield(tp,1-tp,1,1,c,REASON_EFFECT)
end
