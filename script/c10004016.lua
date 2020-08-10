--Forklift Tank Glu-urrgle
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	aux.AddNameCategory(c,NAMECAT_GLUURRGLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--to discard pile, return or draw
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to discard pile, return or draw
scard.tg1=aux.DecktopKJSendtoDPileTarget(PLAYER_OPPO)
function scard.thfilter(c,e)
	return c:IsFaceup() and c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.KJSendDecktoptoDPile(1-tp,1,REASON_EFFECT)==0 then return end
	local tc=Duel.GetOperatedGroup():GetFirst()
	if tc:IsCreature() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
		local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,0,LOCATION_BZONE,1,1,nil,e)
		if g:GetCount()==0 then return end
		Duel.SetTargetCard(g)
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	else
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
