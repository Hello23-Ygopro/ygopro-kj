--Queen Kalima
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MONARCH,RACE_DARK_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
	--to discard pile, banish
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,aux.DecktopKJSendtoDPileTarget(PLAYER_SELF),scard.op1)
	--return
	aux.AddSingleTriggerEffect(c,1,EVENT_ATTACK_ANNOUNCE,nil,nil,aux.SendtoHandOperation(PLAYER_SELF,aux.KJDPileFilter(Card.IsCreature),LOCATION_DPILE,0,1))
	--power up
	aux.EnableUpdatePower(c,4000,nil,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf(Card.IsCivilization,CIVILIZATION_DARKNESS))
end
--to discard pile, banish
function scard.banfilter(c)
	return c:IsFaceup() and c:KJIsBanishable()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetDecktopGroup(tp,3)
	Duel.DisableShuffleCheck()
	Duel.KJSendtoDPile(g1,REASON_EFFECT)
	local ct=g1:FilterCount(aux.KJDPileFilter(Card.IsCivilization),nil,CIVILIZATION_DARKNESS)
	if ct==0 then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_BANISH)
	local g2=Duel.SelectMatchingCard(1-tp,scard.banfilter,1-tp,LOCATION_BZONE,0,ct,ct,nil)
	if g2:GetCount()==0 then return end
	Duel.HintSelection(g2)
	Duel.KJBanish(g2,REASON_EFFECT)
end
