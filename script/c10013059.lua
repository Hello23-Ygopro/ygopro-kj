--Wave Spears
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--draw, discard, return
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--draw, discard, return
function scard.retfilter(c,cost,e)
	return c:IsFaceup() and c:IsManaCost(cost) and c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Draw(tp,2,REASON_EFFECT)>0 then Duel.ShuffleHand(tp) end
	Duel.BreakEffect()
	if Duel.DiscardHand(tp,aux.TRUE,1,1,REASON_EFFECT,e:GetHandler())==0 then return end
	local tc=Duel.GetOperatedGroup():GetFirst()
	local cost=tc:GetManaCost()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.retfilter,tp,LOCATION_BZONE,LOCATION_BZONE,0,1,nil,cost,e)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
end
