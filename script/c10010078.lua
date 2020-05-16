--Corporal Pepper
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BERSERKER,RACE_WILD_VEGGIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--must attack
	aux.EnableEffectCustom(c,EFFECT_MUST_ATTACK)
	--banish replace (to mana zone)
	aux.AddSingleReplaceEffectBanish(c,0,scard.tg1,scard.op1)
end
--banish replace (to mana zone)
scard.tg1=aux.SingleReplaceBanishTarget(Card.IsAbleToMZone)
scard.op1=aux.SingleReplaceBanishOperation(Duel.SendtoMZone,POS_FACEUP_UNTAPPED,REASON_EFFECT+REASON_REPLACE)
