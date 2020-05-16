--Nether Tactician
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SHADOW_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--banish, break
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1)
end
--banish, break
function scard.banfilter(c)
	return c:IsFaceup() and c:KJIsBanishable()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.banfilter,tp,LOCATION_BZONE,0,1,e:GetHandler()) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISH)
	local g=Duel.SelectMatchingCard(tp,scard.banfilter,tp,LOCATION_BZONE,0,0,1,c)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	if Duel.KJBanish(g,REASON_EFFECT)>0 then
		Duel.BreakShield(tp,1-tp,1,1,c,REASON_EFFECT)
	end
end
