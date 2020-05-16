--Ravenous Detrivore
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--to deck, get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER,scard.con1)
	aux.AddEffectDescription(c,2,scard.con1)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER,scard.con2)
	aux.AddEffectDescription(c,3,scard.con2)
end
--to deck, get ability
function scard.tdfilter(c)
	return c:IsCreature() and c:IsAbleToDeck()
end
scard.tg1=aux.CheckCardFunction(aux.KJDPileFilter(scard.tdfilter),LOCATION_DPILE,0)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,aux.KJDPileFilter(scard.tdfilter),tp,LOCATION_DPILE,0,1,1,nil)
	if g:GetCount()==0 or Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_BOTTOM,REASON_EFFECT)==0 then return end
	local c=e:GetHandler()
	--power up
	aux.AddTempEffectUpdatePower(c,c,1,g:GetFirst():GetPower())
end
--double breaker
function scard.con1(e)
	return e:GetHandler():IsPowerAbove(6000)
end
--triple breaker
function scard.con2(e)
	return e:GetHandler():IsPowerAbove(12000)
end
