--Eternal Haven
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MONARCH,RACE_ANGEL_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
	--draw, to battle zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1)
	--cannot be targeted
	aux.EnableCannotBeTargeted(c)
	--power up
	aux.EnableUpdatePower(c,4000,nil,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf(Card.IsCivilization,CIVILIZATION_LIGHT))
end
--draw, to battle zone
function scard.tbfilter(c,e,tp)
	return c:IsCreature() and not c:IsEvolution() and c:IsManaCostBelow(9)
		and c:IsHasEffect(EFFECT_BLOCKER) and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		or Duel.IsExistingMatchingCard(scard.tbfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
	local g=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_HAND,0,0,1,nil,e,tp)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SendtoBZone(g,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
end
