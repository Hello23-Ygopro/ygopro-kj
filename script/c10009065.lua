--Bloomwarden
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_VIRUS,RACE_TREE_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--guard
	aux.EnableGuard(c)
	--banish replace (to mana zone)
	aux.AddSingleReplaceEffectBanish(c,0,scard.tg1,scard.op1)
end
--banish replace (to mana zone)
scard.tg1=aux.SingleReplaceBanishTarget(Card.IsAbleToMZone)
scard.op1=aux.SingleReplaceBanishOperation(Duel.SendtoMZone,POS_FACEUP_UNTAPPED,REASON_EFFECT+REASON_REPLACE)
