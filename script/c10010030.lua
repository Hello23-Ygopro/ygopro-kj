--Cultivate
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to hand or to mana zone
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--to hand or to mana zone
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
	Duel.ConfirmCards(tp,tc)
	Duel.DisableShuffleCheck()
	if tc:IsAbleToHand() and Duel.SelectYesNo(tp,YESNOMSG_TOHAND) then
		Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)
		Duel.ShuffleHand(tp)
	else
		Duel.SendtoMZone(tc,POS_FACEUP_UNTAPPED,REASON_EFFECT)
	end
end
