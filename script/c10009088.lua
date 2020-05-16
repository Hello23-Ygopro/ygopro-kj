--Heretic Prince Var-rakka
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--fast attack
	aux.EnableEffectCustom(c,EFFECT_FAST_ATTACK)
	--get ability (fast attack)
	aux.EnableEffectCustom(c,EFFECT_FAST_ATTACK,nil,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf())
	--return
	aux.AddTriggerEffect(c,0,EVENT_PHASE+PHASE_END,nil,nil,scard.op1,nil,aux.TurnPlayerCondition(PLAYER_SELF))
end
--return
scard.op1=aux.SendtoHandOperation(PLAYER_SELF,Card.IsFaceup,LOCATION_BZONE,0,1)
