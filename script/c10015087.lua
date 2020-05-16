--Timelost Phantom
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SPECTER)
	--creature
	aux.EnableCreatureAttribute(c)
	--break
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,aux.BreakOperation(PLAYER_SELF,PLAYER_SELF,1,1,c))
	--power up
	aux.EnableUpdatePower(c,4000,aux.NoShieldsCondition(PLAYER_SELF))
	aux.AddEffectDescription(c,0,aux.NoShieldsCondition(PLAYER_SELF))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER,aux.NoShieldsCondition(PLAYER_SELF))
	aux.AddEffectDescription(c,1,aux.NoShieldsCondition(PLAYER_SELF))
end
