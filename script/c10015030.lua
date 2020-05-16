--Zephyr Keeper
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STORM_PATROL)
	--creature
	aux.EnableCreatureAttribute(c)
	--break replace (banish)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_SEND_REPLACE)
	e1:SetRange(LOCATION_BZONE)
	e1:SetTarget(scard.tg1)
	e1:SetValue(scard.val1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--break replace (banish)
function scard.repfilter(c,tp)
	return c:IsLocation(LOCATION_SZONE) and c:IsControler(tp)
		and c:GetDestination()~=LOCATION_SZONE and not c:IsReason(REASON_REPLACE)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return eg:FilterCount(scard.repfilter,nil,tp)==1
		and bit.band(r,REASON_BREAK)~=0 and c:KJIsBanishable(e) end
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
		Q: If 2 or more of my shields are broken at the same time, say because I was attacked by a creature that has
		"Double Breaker," can I use "Shield Saver" to save all of them?
		A: No. You can save only one shield using the "Shield Saver" ability.
		https://kaijudo.fandom.com/wiki/Zephyr_Keeper/Rulings
]]
