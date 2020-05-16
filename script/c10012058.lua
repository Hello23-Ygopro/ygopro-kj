--Soul-Devourer Black Feather
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SPECTER)
	--creature
	aux.EnableCreatureAttribute(c)
	--confirm deck (get ability, to discard pile)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--confirm deck (get ability, to discard pile)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	Duel.ConfirmDecktop(tp,3)
	local g1=Duel.GetDecktopGroup(tp,3)
	if g1:IsExists(Card.IsCreature,1,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
		local tc1=g1:FilterSelect(tp,Card.IsCreature,1,1,nil):GetFirst()
		local g2=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,LOCATION_BZONE,nil)
		for tc2 in aux.Next(g2) do
			--power down
			aux.AddTempEffectUpdatePower(e:GetHandler(),tc2,1,-tc1:GetPower())
		end
	end
	Duel.DisableShuffleCheck()
	Duel.KJSendtoDPile(g1,REASON_EFFECT)
end
