--Raging Firebrand
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_VOID_SPAWN,RACE_MELT_WARRIOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--clash (get ability)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,aux.ClashTarget(PLAYER_SELF),scard.op1)
end
--clash (get ability)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.Clash(tp) then return end
	local c=e:GetHandler()
	--powerful attack
	aux.AddTempEffectPowerfulAttack(c,c,1,3000)
	--double breaker
	aux.AddTempEffectBreaker(c,c,2,EFFECT_DOUBLE_BREAKER)
end
