--Starseed Squadron
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ENFORCER,RACE_TREE_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddTriggerEffectPlayerCastSpell(c,0,PLAYER_SELF,nil,nil,nil,scard.op1)
	--get ability (double breaker)
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER,nil,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.IsPowerAbove,6000))
end
--get ability (double breaker)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	if g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		--power up
		aux.AddTempEffectUpdatePower(e:GetHandler(),tc,1,2000)
	end
end
