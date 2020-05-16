--Zombie Backhoe
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ZOMBIE,RACE_STOMPER)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddTriggerEffect(c,0,EVENT_DISCARD,nil,nil,scard.op1)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,eg:GetCount(),eg:GetCount(),nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	local c=e:GetHandler()
	for tc in aux.Next(g) do
		--powerful attack
		aux.AddTempEffectPowerfulAttack(c,tc,1,3000)
		--double breaker
		aux.AddTempEffectBreaker(c,tc,2,EFFECT_DOUBLE_BREAKER)
	end
end
