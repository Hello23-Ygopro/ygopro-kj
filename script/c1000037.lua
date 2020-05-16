--Gilded Archon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STORM_PATROL,RACE_CYBER_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--skirmisher
	aux.EnableSkirmisher(c)
	--cast for free
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
end
--cast for free
function scard.castfilter(c)
	return c:IsSpell() and c:IsManaCostBelow(3)
end
scard.tg1=aux.CheckCardFunction(aux.KJDPileFilter(scard.castfilter),LOCATION_DPILE,0)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CASTFREE)
	local g=Duel.SelectMatchingCard(tp,aux.KJDPileFilter(scard.castfilter),tp,LOCATION_DPILE,0,1,1,nil)
	if g:GetCount()==0 or Duel.CastFree(g)==0 then return end
	--redirect (to deck)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_TO_DPILE_REDIRECT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetValue(LOCATION_DECKBOT)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TODECK)
	g:GetFirst():RegisterEffect(e1,true)
end
