--Lore-Strider
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD,RACE_SPIRIT_TOTEM)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,1))
	--banish replace (to mana zone)
	aux.AddSingleReplaceEffectBanish(c,1,scard.tg1,scard.op1)
end
--banish replace (to mana zone)
scard.tg1=aux.SingleReplaceBanishTarget(Card.IsAbleToMZone)
scard.op1=aux.SingleReplaceBanishOperation(Duel.SendtoMZone,POS_FACEUP_UNTAPPED,REASON_EFFECT+REASON_REPLACE)
