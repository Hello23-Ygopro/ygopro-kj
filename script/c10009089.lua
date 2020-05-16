--Borran, the Reality Shaper
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_EARTH_EATER,RACE_COLOSSUS)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--confirm deck (to battle or to hand)
	aux.AddSingleTriggerEffect(c,0,EVENT_BANISHED,true,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
	aux.AddTriggerEffect(c,0,EVENT_BANISHED,true,aux.CheckDeckFunction(PLAYER_SELF),scard.op1,nil,aux.LeaveBZoneCondition(PLAYER_SELF))
end
--confirm deck (to battle or to hand)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	for i=1,eg:GetCount() do
		Duel.ConfirmDecktop(tp,1)
		local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
		Duel.DisableShuffleCheck()
		if tc:IsCreature() and not tc:IsEvolution() and tc:IsAbleToBZone(e,0,tp,false,false) then
			Duel.SendtoBZone(tc,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
		else
			if Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)>0 then Duel.ConfirmCards(1-tp,tc) end
		end
	end
end
