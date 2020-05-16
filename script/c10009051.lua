--Flamewing Phoenix
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STORM_PATROL,RACE_FIRE_BIRD)
	--creature
	aux.EnableCreatureAttribute(c)
	--powerful attack
	aux.EnablePowerfulAttack(c,3000)
	--banish replace (to shield)
	aux.AddSingleReplaceEffectBanish(c,0,scard.tg1,scard.op1)
end
--banish replace (to shield)
scard.tg1=aux.SingleReplaceBanishTarget(Card.IsAbleToSZone)
scard.op1=aux.SingleReplaceBanishOperation(Duel.SendtoSZone)
