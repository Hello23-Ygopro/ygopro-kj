--Mindwrack Moth
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BRAIN_JACKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--confirm hand (discard)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--confirm hand (discard)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()==0 then return end
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local sg=g:FilterSelect(tp,Card.IsSpell,1,1,nil)
	Duel.KJSendtoDPile(sg,REASON_EFFECT+REASON_DISCARD)
	Duel.ShuffleHand(1-tp)
end
