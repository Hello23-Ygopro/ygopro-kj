--Feral Scaradorable
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA)
	aux.AddNameCategory(c,NAMECAT_SCARADORABLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--to discard pile, banish or discard
	aux.AddTriggerEffect(c,0,EVENT_PHASE+PHASE_END,nil,nil,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--to discard pile, banish or discard
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and e:GetHandler():GetBrokenShieldCount()>0
end
function scard.banfilter(c,e)
	return c:IsFaceup() and c:KJIsBanishable() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.KJSendDecktoDPile(1-tp,1,REASON_EFFECT)==0 then return end
	local tc=Duel.GetOperatedGroup():GetFirst()
	if tc:IsSpell() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISH)
		local g=Duel.SelectMatchingCard(tp,scard.banfilter,tp,0,LOCATION_BZONE,1,1,nil,e)
		if g:GetCount()==0 then return end
		Duel.SetTargetCard(g)
		Duel.KJBanish(g,REASON_EFFECT)
	else
		Duel.DiscardHand(1-tp,aux.TRUE,1,1,REASON_EFFECT)
	end
end
