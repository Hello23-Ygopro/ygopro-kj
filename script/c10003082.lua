--Kronkos, General of Fear
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SHADOW_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--banish replace (banish)
	aux.AddReplaceEffectBanish(c,0,scard.tg1,scard.op1,scard.val1)
end
--banish replace (banish)
function scard.repfilter(c,tp)
	return c:IsLocation(LOCATION_BZONE) and c:IsFaceup() and c:KJIsRace(RACE_SHADOW_CHAMPION)
		and c:IsControler(tp) and not c:IsReason(REASON_REPLACE)
end
function scard.banfilter(c,e)
	return c:IsFaceup() and c:KJIsBanishable(e) and not c:IsStatus(STATUS_BANISH_CONFIRMED+STATUS_BATTLE_BANISHED)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(scard.repfilter,1,nil,tp)
		and Duel.IsExistingMatchingCard(scard.banfilter,tp,LOCATION_BZONE,0,1,nil,e) end
	if Duel.SelectYesNo(tp,aux.Stringid(sid,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISHREPLACE)
		local g=Duel.SelectMatchingCard(tp,scard.banfilter,tp,LOCATION_BZONE,0,1,1,nil,e)
		e:SetLabelObject(g:GetFirst())
		g:GetFirst():SetStatus(STATUS_BANISH_CONFIRMED,true)
		return true
	else return false end
end
function scard.val1(e,c)
	return scard.repfilter(c,e:GetHandlerPlayer())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	local tc=e:GetLabelObject()
	tc:SetStatus(STATUS_BANISH_CONFIRMED,false)
	Duel.KJBanish(tc,REASON_EFFECT+REASON_REPLACE)
end
--[[
	References
		1. Proxy Dragon
		https://github.com/Fluorohydride/ygopro-scripts/blob/master/c22862454.lua
]]
