--Exalarc, Grand Metachron
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_AQUAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--return, confirm deck (cast for free)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1)
end
--return, confirm deck (cast for free)
function scard.thfilter(c)
	return c:IsFaceup() and c:IsAbleToHand()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.thfilter,tp,LOCATION_BZONE,0,1,e:GetHandler()) end
end
function scard.castfilter(c,cost)
	return c:IsSpell() and c:IsManaCostBelow(cost)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g1=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_BZONE,0,1,1,e:GetHandler())
	if g1:GetCount()==0 then return end
	Duel.HintSelection(g1)
	if Duel.SendtoHand(g1,PLAYER_OWNER,REASON_EFFECT)==0 or Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local cost=g1:GetFirst():GetManaCost()
	Duel.ConfirmDecktop(tp,cost)
	local g2=Duel.GetDecktopGroup(tp,cost)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CASTFREE)
	local sg=g2:FilterSelect(tp,scard.castfilter,1,1,nil,cost)
	g2:Sub(sg)
	if sg:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.CastFree(sg)
	end
	if g2:GetCount()>0 then
		aux.SortDeck(tp,tp,cost-sg:GetCount(),SEQ_DECK_BOTTOM)
	end
end
