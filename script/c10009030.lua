--Skycrusher's Volcano-Ship
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_INFERNO_COMPLEX)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--attack untapped
	aux.EnableAttackUntapped(c)
	--get ability
	aux.AddSingleTriggerEffectWinBattle(c,0,nil,nil,scard.op1)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,1,1,c)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	--attack untapped
	aux.AddTempEffectCustom(c,g:GetFirst(),1,EFFECT_ATTACK_UNTAPPED)
end
