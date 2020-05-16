--Frantic Blast
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--confirm deck (banish, to hand)
	aux.AddSpellCastEffect(c,0,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--confirm deck (banish, to hand)
function scard.banfilter(c,e,pwr)
	return c:IsFaceup() and c:GetPower()<pwr and c:KJIsBanishable() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	Duel.ConfirmDecktop(tp,1)
	local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
	if tc:IsCreature() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISH)
		local g=Duel.SelectMatchingCard(tp,scard.banfilter,tp,0,LOCATION_BZONE,1,1,nil,e,tc:GetPower())
		if g:GetCount()>0 then
			Duel.SetTargetCard(g)
			Duel.KJBanish(g,REASON_EFFECT)
		end
	end
	Duel.DisableShuffleCheck()
	if Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)>0 then Duel.ConfirmCards(1-tp,tc) end
end
