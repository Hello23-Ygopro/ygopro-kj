--Dawn Giant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TREE_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--confirm deck (get ability)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
--confirm deck (get ability)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	Duel.ConfirmDecktop(tp,1)
	local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
	local c=e:GetHandler()
	if tc:IsCreature() then
		--power up
		aux.AddTempEffectUpdatePower(c,c,1,6000)
		--triple breaker
		aux.AddTempEffectBreaker(c,c,2,EFFECT_TRIPLE_BREAKER)
	end
	Duel.MoveSequence(tc,SEQ_DECK_BOTTOM)
end
