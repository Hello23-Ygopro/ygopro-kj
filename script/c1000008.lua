--Flare Inhibitor
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ENFORCER)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--skirmisher
	aux.EnableSkirmisher(c)
	--banish replace (to shield)
	aux.AddSingleReplaceEffectBanish(c,0,scard.tg1,scard.op1)
end
--banish replace (to shield)
scard.tg1=aux.SingleReplaceBanishTarget(Card.IsAbleToSZone)
scard.op1=aux.SingleReplaceBanishOperation(Duel.SendtoSZone)
