--Air Warden Prickleback
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BEAST_KIN,RACE_MEGABUG)
	--creature
	aux.EnableCreatureAttribute(c)
	--protector
	aux.EnableProtector(c)
	--skirmisher
	aux.EnableSkirmisher(c)
	--power up
	aux.EnableUpdatePower(c,5000,scard.con1)
	--return or to deck
	aux.AddSingleTriggerEffectWinBattle(c,0,true,aux.CheckCardFunction(aux.ManaZoneFilter(scard.filter),LOCATION_MZONE,0),scard.op1)
end
--power up
function scard.con1(e)
	local tc=e:GetHandler():GetBattleTarget()
	return tc and tc:IsFaceup() and tc:KJIsRace(RACE_VOID_SPAWN)
end
--return or to deck
function scard.filter(c)
	return c:IsAbleToHand() or c:IsAbleToDeck()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CARD)
	local g=Duel.SelectMatchingCard(aux.ManaZoneFilter(scard.filter),tp,LOCATION_MZONE,0,1,1,nil)
	if g:GetCount()==0 then return end
	if g:GetFirst():IsAbleToHand() and Duel.SelectYesNo(tp,YESNOMSG_TOHAND) then
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	else
		Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_TOP,REASON_EFFECT)
	end
end
