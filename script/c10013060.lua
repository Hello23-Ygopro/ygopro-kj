--Whirlpool Warden
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_AQUAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--guard
	aux.EnableGuard(c)
	--banish replace (return)
	aux.AddSingleReplaceEffectBanish(c,0,scard.tg1,scard.op1,aux.ExistingCardCondition(scard.cfilter))
end
--banish replace (return)
function scard.cfilter(c)
	return c:IsFaceup() and c:IsEvolution()
end
scard.tg1=aux.SingleReplaceBanishTarget(Card.IsAbleToHand)
scard.op1=aux.SingleReplaceBanishOperation(Duel.SendtoHand,PLAYER_OWNER,REASON_EFFECT+REASON_REPLACE)
