--Dark-Seer Jurlon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ENFORCER,RACE_ROT_WORM)
	--creature
	aux.EnableCreatureAttribute(c)
	--confirm hand (discard)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,scard.op1)
	--tap or untap
	aux.AddTriggerEffectBecomeTarget(c,1,nil,scard.tg1,scard.op2,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--confirm hand (discard)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()==0 then return end
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local sg=g:FilterSelect(tp,Card.IsSpell,1,1,nil)
	Duel.KJSendtoDPile(sg,REASON_EFFECT+REASON_DISCARD)
	Duel.ShuffleHand(1-tp)
end
--tap or untap
function scard.cfilter(c,tp)
	return c:IsLocation(LOCATION_BZONE) and c:IsControler(tp)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) or not re:GetHandler():IsSpell() then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return g and g:IsExists(scard.cfilter,1,nil,tp)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,Card.IsFaceup,LOCATION_BZONE,LOCATION_BZONE,0,1,HINTMSG_TARGET)
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not tc:IsFaceup() then return end
	if tc:IsUntapped() then
		Duel.Tap(tc,REASON_EFFECT)
	elseif tc:IsTapped() then
		Duel.Untap(tc,REASON_EFFECT)
	end
end
