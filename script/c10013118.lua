--Volcano Trooper
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BERSERKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddTriggerEffect(c,0,EVENT_LEAVE_BZONE,nil,nil,scard.op1,nil,aux.LeaveBZoneCondition(PLAYER_OPPO))
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	for i=1,eg:GetCount() do
		--powerful attack
		aux.AddTempEffectPowerfulAttack(c,c,1,2000)
		--double breaker
		aux.AddTempEffectBreaker(c,c,2,EFFECT_DOUBLE_BREAKER)
	end
end
