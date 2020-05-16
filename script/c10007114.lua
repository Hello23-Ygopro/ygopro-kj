--Infernus the Immolator
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MONARCH,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
	--banish
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--break
	aux.AddTriggerEffectBecomeTarget(c,1,nil,nil,aux.BreakOperation(PLAYER_SELF,PLAYER_OPPO,3,3,c))
	--power up
	aux.EnableUpdatePower(c,4000,nil,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf(Card.IsCivilization,CIVILIZATION_FIRE))
end
--banish
scard.tg1=aux.TargetTotalPowerBelowTarget(PLAYER_SELF,0,LOCATION_BZONE,8000,HINTMSG_BANISH)
scard.op1=aux.TargetCardsOperation(Duel.KJBanish,REASON_EFFECT)
