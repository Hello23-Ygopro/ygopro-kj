--Steamtank Kryon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STOMPER,RACE_MEGABUG)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1,nil,scard.con1)
end
--get ability
function scard.cfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(scard.cfilter,e:GetHandler(),tp)
	g:KeepAlive()
	e:SetLabelObject(g)
	return g:GetCount()>0
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local c=e:GetHandler()
	for tc in aux.Next(g) do
		--power up
		aux.AddTempEffectUpdatePower(c,tc,1,2000)
		--fast attack
		aux.AddTempEffectCustom(c,tc,2,EFFECT_FAST_ATTACK)
	end
end
