--Rothos the Destroyer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STOMPER)
	--creature
	aux.EnableCreatureAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--banish
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,aux.SelfBanishTarget,scard.op1)
end
--banish
function scard.banfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(2000) and c:KJIsBanishable()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or Duel.KJBanish(c,REASON_EFFECT)==0 then return end
	local g=Duel.GetMatchingGroup(scard.banfilter,tp,0,LOCATION_BZONE,nil)
	Duel.KJBanish(g,REASON_EFFECT)
end
