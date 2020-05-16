--Hypnobot
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_UNDERTOW_ENGINE)
	--creature
	aux.EnableCreatureAttribute(c)
	--to deck
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--to deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	scard.todeck(tp)
	scard.todeck(1-tp)
end
function scard.todeck(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_TOP,REASON_EFFECT)
	end
end
