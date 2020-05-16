--Blastforge Captain
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DRAKON)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_DRAKON))
	--banish
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--banish
scard.tg1=aux.TargetTotalPowerBelowTarget(PLAYER_SELF,0,LOCATION_BZONE,4000,HINTMSG_BANISH)
scard.op1=aux.TargetCardsOperation(Duel.KJBanish,REASON_EFFECT)
