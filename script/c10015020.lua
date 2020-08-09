--Regent's Attendant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MECHA_THUNDER)
	--creature
	aux.EnableCreatureAttribute(c)
	--banish replace (banish)
	aux.AddReplaceEffectBanish(c,0,scard.tg1,scard.op1,scard.val1)
end
--banish replace (banish)
function scard.repfilter(c,tp)
	return c:IsLocation(LOCATION_BZONE) and c:IsFaceup() and c:IsPowerAbove(6000)
		and c:IsControler(tp) and not c:IsReason(REASON_REPLACE)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return eg:FilterCount(scard.repfilter,c,tp)==1 and c:KJIsBanishable(e) end
	return Duel.SelectYesNo(tp,aux.Stringid(sid,1))
end
function scard.val1(e,c)
	return scard.repfilter(c,e:GetHandlerPlayer())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.KJBanish(e:GetHandler(),REASON_EFFECT+REASON_REPLACE)
end
--[[
	Rulings
	Q: If more than one of my creatures that has power 6000 or more would be banished at the same time, can I banish
	Regent's Attendant instead of banishing all of them?
		A: No. You can save only one creature this way.
	https://kaijudo.fandom.com/wiki/Regent%27s_Attendant/Rulings
]]
