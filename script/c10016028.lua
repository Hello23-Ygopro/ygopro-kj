--Erupting Caveworm
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ROT_WORM)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--slayer
	aux.EnableSlayer(c)
	--banish replace (to deck)
	aux.AddSingleReplaceEffectBanish(c,0,scard.tg1)
end
--banish replace (to deck)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToDeck() and not c:IsReason(REASON_REPLACE) end
	if Duel.SelectYesNo(tp,aux.Stringid(sid,1)) then
		Duel.Hint(HINT_CARD,0,sid)
		Duel.SendtoDeck(c,PLAYER_OWNER,SEQ_DECK_TOP,REASON_EFFECT+REASON_REPLACE)
		return true
	else return false end
end
