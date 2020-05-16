--Toronok the Voidshaper
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_VOID_SPAWN,RACE_SKYFORCE_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--clash (to battle or cast for free)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,aux.ClashTarget(PLAYER_SELF),scard.op1)
end
--clash (to battle or cast for free)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 or Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)==0 then return end
	Duel.ConfirmDecktop(tp,1)
	local tc1=Duel.GetDecktopGroup(tp,1):GetFirst()
	Duel.RaiseEvent(tc1,EVENT_CUSTOM+EVENT_CLASH,e,0,0,tp,0)
	Duel.RaiseSingleEvent(tc1,EVENT_CUSTOM+EVENT_CLASH,e,0,0,tp,0)
	Duel.ConfirmDecktop(1-tp,1)
	local tc2=Duel.GetDecktopGroup(1-tp,1):GetFirst()
	Duel.RaiseEvent(tc2,EVENT_CUSTOM+EVENT_CLASH,e,0,0,1-tp,0)
	Duel.RaiseSingleEvent(tc2,EVENT_CUSTOM+EVENT_CLASH,e,0,0,1-tp,0)
	local win_clash=tc1:GetManaCost()>=tc2:GetManaCost()
	local lose_clash=tc1:GetManaCost()<tc2:GetManaCost()
	if win_clash then
		Duel.Hint(HINT_MESSAGE,tp,DESC_WINCLASH)
		Duel.Hint(HINT_MESSAGE,1-tp,DESC_LOSECLASH)
	elseif lose_clash then
		Duel.Hint(HINT_MESSAGE,tp,DESC_LOSECLASH)
		Duel.Hint(HINT_MESSAGE,1-tp,DESC_WINCLASH)
	end
	if (tc1:IsCreature() and not tc1:IsEvolution() and tc1:IsAbleToBZone(e,0,tp,false,false) or tc1:IsSpell())
		and win_clash and Duel.SelectYesNo(tp,YESNOMSG_PLAYFREE) then
		if tc1:IsCreature() then
			Duel.SendtoBZone(tc1,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
		elseif tc1:IsSpell() then
			Duel.CastFree(tc1)
		end
	else
		Duel.MoveSequence(tc1,SEQ_DECK_BOTTOM)
	end
	Duel.MoveSequence(tc2,SEQ_DECK_BOTTOM)
end
