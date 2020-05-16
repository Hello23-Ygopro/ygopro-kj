--Skycrusher's Elite
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DRAKON)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1,nil,scard.con1)
end
--get ability
function scard.cfilter(c,tp)
	return c:IsFaceup() and c:IsPowerBelow(2000) and c:IsControler(tp)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(scard.cfilter,e:GetHandler(),tp)
	g:KeepAlive()
	e:SetLabelObject(g)
	return g:GetCount()>0
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	for tc in aux.Next(g) do
		--fast attack
		aux.AddTempEffectCustom(e:GetHandler(),tc,1,EFFECT_FAST_ATTACK)
	end
end
--[[
	Rulings
		https://kaijudo.fandom.com/wiki/Skycrusher%27s_Elite/Rulings
	References
		1. Bujingi Raven
		https://github.com/Fluorohydride/ygopro-scripts/blob/fedc245/c11958188.lua#L21
]]
