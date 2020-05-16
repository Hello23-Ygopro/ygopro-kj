--Renegade Hero Finbarr
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--draw
	aux.AddTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,aux.DrawTarget(PLAYER_SELF),scard.op1,nil,scard.con1)
	--get ability (ignore guard)
	aux.EnableEffectCustom(c,EFFECT_IGNORE_GUARD,nil,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.IsHasEffect,EFFECT_GUARD))
	--sort
	aux.AddTriggerEffect(c,1,EVENT_PHASE+PHASE_END,nil,nil,scard.op2,nil,aux.TurnPlayerCondition(PLAYER_SELF))
end
--draw
function scard.cfilter(c,tp)
	return c:IsFaceup() and c:IsHasEffect(EFFECT_GUARD)
		and c:GetSummonType()==SUMMON_TYPE_NONEVOLVE and c:GetSummonPlayer()==tp
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.cfilter,1,nil,tp)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,eg:GetCount(),REASON_EFFECT)
end
--sort
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local g=Duel.GetDecktopGroup(tp,3)
	local ct=g:GetCount()
	Duel.ConfirmCards(tp,g)
	if ct==1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECKTOP)
	local sg=g:Select(tp,1,1,nil)
	Duel.DisableShuffleCheck() --part of workaround to exclude from the sorting process
	Duel.SendtoHand(sg,PLAYER_OWNER,REASON_RULE) --workaround to exclude from the sorting process
	aux.SortDeck(tp,tp,ct-sg:GetCount(),SEQ_DECK_BOTTOM)
	Duel.SendtoDeck(sg,PLAYER_OWNER,SEQ_DECK_TOP,REASON_RULE) --part of workaround to exclude from the sorting process
end
