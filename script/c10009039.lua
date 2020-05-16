--Transforming Totem
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SPIRIT_TOTEM)
	--creature
	aux.EnableCreatureAttribute(c)
	--to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
	--banish replace (to mana zone)
	aux.AddSingleReplaceEffectBanish(c,1,scard.tg2,scard.op2)
end
--to mana zone
scard.tg1=aux.CheckCardFunction(Card.IsAbleToMZone,LOCATION_HAND,0)
scard.op1=aux.SendtoMZoneOperation(PLAYER_SELF,nil,LOCATION_HAND,0,1)
--banish replace (to mana zone)
scard.tg2=aux.SingleReplaceBanishTarget(Card.IsAbleToMZone)
scard.op2=aux.SingleReplaceBanishOperation(Duel.SendtoMZone,POS_FACEUP_UNTAPPED,REASON_EFFECT+REASON_REPLACE)
