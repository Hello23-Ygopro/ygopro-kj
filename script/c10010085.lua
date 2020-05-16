--Almighty Colossus
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MONARCH,RACE_COLOSSUS)
	--creature
	aux.EnableCreatureAttribute(c)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
	--do battle
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--confirm deck (to battle)
	aux.AddSingleTriggerEffect(c,1,EVENT_ATTACK_ANNOUNCE,nil,nil,scard.op2)
	aux.AddTriggerEffectBecomeTarget(c,1,nil,nil,scard.op2)
	--power up
	aux.EnableUpdatePower(c,4000,nil,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf(Card.IsCivilization,CIVILIZATION_NATURE))
end
--do battle
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,Card.IsFaceup,0,LOCATION_BZONE,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsFaceup() and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.DoBattle(c,tc)
	end
end
--confirm deck (to battle)
function scard.tbfilter(c,e,tp)
	return c:IsCreature() and c:IsCivilization(CIVILIZATION_NATURE) and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	Duel.ConfirmDecktop(tp,3)
	local g=Duel.GetDecktopGroup(tp,3)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
	local sg=g:FilterSelect(tp,scard.tbfilter,0,1,nil,e,tp)
	if sg:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.SendtoBZone(sg,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
	end
	if g:GetCount()>0 then
		aux.SortDeck(tp,tp,3-sg:GetCount(),SEQ_DECK_BOTTOM)
	end
end
