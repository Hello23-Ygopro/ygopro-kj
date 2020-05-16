--Dragon Knight Volaron
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--fast attack
	aux.EnableEffectCustom(c,EFFECT_FAST_ATTACK)
	--powerful attack
	aux.EnablePowerfulAttack(c,4000)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to shield zone
	aux.AddTriggerEffect(c,0,EVENT_PHASE+PHASE_END,true,scard.tg1,scard.op1,nil,scard.con1)
end
--to shield zone
scard.con1=aux.AND(aux.TurnPlayerCondition(PLAYER_SELF),aux.SelfTappedCondition)
scard.tg1=aux.DecktopSendtoSZoneTarget(PLAYER_SELF)
scard.op1=aux.DecktopSendtoSZoneOperation(PLAYER_SELF,1)
