--Lux
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_FIRE_BIRD)
	--creature
	aux.EnableCreatureAttribute(c)
	--cost down
	aux.EnableUpdatePlayCost(c,-1,nil,LOCATION_ALL,0,aux.TargetBoolFunction(Card.IsRaceCategory,RACECAT_DRAGON))
	--banish replace (banish)
	aux.AddReplaceEffectBanish(c,0,scard.tg1,scard.op1,scard.val1)
end
--banish replace (banish)
function scard.repfilter(c,tp)
	return c:IsLocation(LOCATION_BZONE) and c:IsFaceup() and c:IsRaceCategory(RACECAT_DRAGON)
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
	Q: If more than one of my Dragons would be banished at the same time, can I banish Lux and save all of them?
		A: No. "Andromeda's Envoy" can be used to save one Dragon only.
	https://kaijudo.fandom.com/wiki/Lux/Rulings

	References
	* Desert Protector
	https://github.com/Fluorohydride/ygopro-scripts/blob/d0fa049/c38981606.lua#L11
	* Koa'ki Meiru Prototype
	https://github.com/Fluorohydride/ygopro-scripts/blob/d0fa049/c176392.lua#L3
	* Secret Six Samurai - Fuma
	https://github.com/Fluorohydride/ygopro-scripts/blob/9c71d73/c71207871.lua#L14
]]
