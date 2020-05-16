--Ripper Reaper
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SHADOW_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--banish
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
end
--banish
function scard.banfilter(c)
	return c:IsFaceup() and c:KJIsBanishable()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.banfilter,tp,LOCATION_BZONE,0,1,e:GetHandler()) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISH)
	local g1=Duel.SelectMatchingCard(tp,scard.banfilter,tp,LOCATION_BZONE,0,1,1,e:GetHandler())
	if g1:GetCount()==0 then return end
	Duel.HintSelection(g1)
	if Duel.KJBanish(g1,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_BANISH)
	local g2=Duel.SelectMatchingCard(1-tp,scard.banfilter,1-tp,LOCATION_BZONE,0,1,1,nil)
	if g2:GetCount()==0 then return end
	Duel.HintSelection(g2)
	Duel.KJBanish(g2,REASON_EFFECT)
end
