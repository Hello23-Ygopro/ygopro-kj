--Aqua Infiltrator
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_AQUAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,1))
	--banish replace (return)
	aux.AddSingleReplaceEffectBanish(c,1,scard.tg1,scard.op1)
end
--banish replace (return)
scard.tg1=aux.SingleReplaceBanishTarget(Card.IsAbleToHand)
scard.op1=aux.SingleReplaceBanishOperation(Duel.SendtoHand,PLAYER_OWNER,REASON_EFFECT+REASON_REPLACE)
