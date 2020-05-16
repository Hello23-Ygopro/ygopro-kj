--General Skycrusher
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--banish
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--get ability
	aux.AddTriggerEffect(c,1,EVENT_ATTACK_ANNOUNCE,nil,nil,scard.op2,nil,scard.con1)
end
--banish
function scard.banfilter(c)
	return c:IsFaceup() and c:IsPowerBelow(3000) and c:KJIsBanishable()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.banfilter,0,LOCATION_BZONE,1,1,HINTMSG_BANISH)
scard.op1=aux.TargetCardsOperation(Duel.KJBanish,REASON_EFFECT)
--get ability
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc:IsControler(tp) and tc~=e:GetHandler()
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	--powerful attack
	aux.AddTempEffectPowerfulAttack(e:GetHandler(),Duel.GetAttacker(),2,3000)
end
