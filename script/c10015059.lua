--Wavecrest Crawler
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_EARTH_EATER)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddTriggerEffect(c,0,EVENT_DRAW,nil,nil,scard.op1,nil,aux.EventPlayerCondition(PLAYER_SELF))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER,scard.con1)
	aux.AddEffectDescription(c,2,scard.con1)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	for i=1,eg:GetCount() do
		--power up
		aux.AddTempEffectUpdatePower(c,c,1,1000)
	end
end
--double breaker
function scard.con1(e)
	return e:GetHandler():IsPowerAbove(6000)
end
