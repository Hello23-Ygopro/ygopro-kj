--Galzak of Shadow Pass
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SHADOW_CHAMPION,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--get ability
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,Card.IsFaceup,0,LOCATION_BZONE,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		--power down
		aux.AddTempEffectUpdatePower(c,tc,1,-3000)
	end
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		--power up
		aux.AddTempEffectUpdatePower(c,c,2,3000)
	end
end
