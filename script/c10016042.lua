--Leaping Hissy
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DUNE_GECKO)
	--creature
	aux.EnableCreatureAttribute(c)
	--change level
	aux.EnableChangeClashManaCost(c,1,10)
	--banish or break
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--banish or break
function scard.banfilter(c)
	return c:IsFaceup() and c:IsHasEffect(EFFECT_BLOCKER) and c:KJIsBanishable()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_BANISH)
	local g=Duel.SelectMatchingCard(1-tp,scard.banfilter,1-tp,LOCATION_BZONE,0,0,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.KJBanish(g,REASON_EFFECT)
	else
		Duel.BreakShield(tp,1-tp,1,1,e:GetHandler(),REASON_EFFECT)
	end
end
