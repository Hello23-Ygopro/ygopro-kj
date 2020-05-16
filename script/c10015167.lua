--Drakomech Commander
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ENFORCER,RACE_DRAKON)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter,scard.evofilter)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--get ability (fast attack)
	aux.EnableEffectCustom(c,EFFECT_FAST_ATTACK,nil,LOCATION_BZONE,0)
	--confirm deck (to battle or to hand)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
	aux.AddTriggerEffectBecomeTarget(c,0,nil,nil,scard.op1)
end
--vortex evolution
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATIONS_LF)
--confirm deck (to battle or to hand)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	Duel.ConfirmDecktop(tp,1)
	local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
	Duel.DisableShuffleCheck()
	if tc:IsCreature() and not tc:IsEvolution() and tc:IsManaCostBelow(4) and tc:IsAbleToBZone(e,0,tp,false,false) then
		Duel.SendtoBZone(tc,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
	else
		if Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)>0 then
			Duel.ConfirmCards(1-tp,tc)
			Duel.ShuffleHand(tp)
		end
	end
end
