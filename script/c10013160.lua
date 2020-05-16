--Thunderaxe Shaman
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BERSERKER,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddTriggerEffectWinBattle(c,0,nil,nil,scard.op1,nil,aux.BattleWinCondition())
	--get ability (double breaker)
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER,nil,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.IsPowerAbove,6000))
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	if g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		--powerful attack
		aux.AddTempEffectPowerfulAttack(e:GetHandler(),tc,1,2000)
	end
end
