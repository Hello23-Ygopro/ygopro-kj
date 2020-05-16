--Kurragar of the Hordes
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_EARTHSTRIKE_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
	--confirm deck (to battle)
	aux.AddTriggerEffectEnterMZone(c,0,PLAYER_SELF,nil,nil,scard.op1)
end
--confirm deck (to battle)
function scard.tbfilter(c)
	return c:IsCreature() and not c:IsEvolution()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	for i=1,eg:GetCount() do
		Duel.ConfirmDecktop(tp,1)
		local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
		if tc:IsCreature() and not tc:IsEvolution() and tc:IsAbleToBZone(e,0,tp,false,false) then
			Duel.DisableShuffleCheck()
			Duel.SendtoBZone(tc,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
		else
			Duel.MoveSequence(tc,SEQ_DECK_BOTTOM)
		end
	end
end
