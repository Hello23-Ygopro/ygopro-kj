--Bronze-Arm Fanatic
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1)
	--banish replace (to mana zone)
	aux.AddSingleReplaceEffectBanish(c,1,scard.tg2,scard.op2)
end
--to mana zone
scard.tg1=aux.DecktopSendtoMZoneTarget(PLAYER_SELF)
scard.op1=aux.DecktopSendtoMZoneOperation(PLAYER_SELF,1)
--banish replace (to mana zone)
scard.tg2=aux.SingleReplaceBanishTarget(Card.IsAbleToMZone)
scard.op2=aux.SingleReplaceBanishOperation(Duel.SendtoMZone,POS_FACEUP_UNTAPPED,REASON_EFFECT+REASON_REPLACE)
