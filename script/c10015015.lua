--Overshields
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--to shield zone
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--to shield zone
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendDecktoptoSZone(tp,2)
	local reset_count=(Duel.GetTurnPlayer()==tp and 2 or 1)
	--to discard pile
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_DRAW)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.TurnPlayerCondition(PLAYER_SELF))
	e1:SetOperation(scard.op2)
	e1:SetReset(RESET_PHASE+PHASE_DRAW,reset_count)
	Duel.RegisterEffect(e1,tp)
end
--to discard pile
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.ShieldZoneFilter(Card.KJIsAbleToDPile),tp,LOCATION_SZONE,0,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODPILE)
	local sg=g:Select(tp,2,2,nil)
	Duel.HintSelection(sg)
	Duel.KJSendtoDPile(sg,REASON_EFFECT)
end
