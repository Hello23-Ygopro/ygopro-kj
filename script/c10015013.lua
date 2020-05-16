--Justice Archon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddTriggerEffectPlayerCastSpell(c,0,PLAYER_SELF,nil,nil,nil,scard.op1)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--power up
	aux.AddTempEffectUpdatePower(c,c,1,2000)
	--double breaker
	aux.AddTempEffectBreaker(c,c,2,EFFECT_DOUBLE_BREAKER)
end
