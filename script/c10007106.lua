--Lotus Warrior
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STOMPER,RACE_WILD_VEGGIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,3000,scard.con1)
	--banish replace (to mana zone)
	aux.AddSingleReplaceEffectBanish(c,0,scard.tg1,scard.op1)
end
--power up
function scard.con1(e)
	local tc=e:GetHandler():GetBattleTarget()
	return tc and tc:IsFaceup() and tc:IsHasEffect(EFFECT_BLOCKER)
end
--banish replace (to mana zone)
scard.tg1=aux.SingleReplaceBanishTarget(Card.IsAbleToMZone)
scard.op1=aux.SingleReplaceBanishOperation(Duel.SendtoMZone,POS_FACEUP_UNTAPPED,REASON_EFFECT+REASON_REPLACE)
