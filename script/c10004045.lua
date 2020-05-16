--Bronze-Arm Sabertooth
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_BEAST_KIN))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--banish replace (to mana zone)
	aux.AddSingleReplaceEffectBanish(c,0,scard.tg1,scard.op1)
end
--banish replace (to mana zone)
scard.tg1=aux.SingleReplaceBanishTarget(Card.IsAbleToMZone)
scard.op1=aux.SingleReplaceBanishOperation(Duel.SendtoMZone,POS_FACEUP_UNTAPPED,REASON_EFFECT+REASON_REPLACE)
