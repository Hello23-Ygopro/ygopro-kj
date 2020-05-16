--Abyssal Engulfer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_VOID_SPAWN,RACE_LEVIATHAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--clash (to deck)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,aux.ClashTarget(PLAYER_SELF),scard.op1)
end
--clash (to deck)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.Clash(tp) then return end
	scard.todeck(tp)
	scard.todeck(1-tp)
end
function scard.todeck(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,aux.KJDPileFilter(Card.IsAbleToDeck),tp,LOCATION_DPILE,0,0,2,nil)
	if g:GetCount>0 then
		Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_BOTTOM,REASON_EFFECT)
	end
end
