--Krogon, Blazing Devastation
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--do battle
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	aux.AddTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op2,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--do battle
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,Card.IsFaceup,0,LOCATION_BZONE,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsFaceup() and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.DoBattle(c,tc)
	end
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc:IsControler(tp) and tc:IsRaceCategory(RACECAT_DRAGON) and tc~=e:GetHandler()
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc1=eg:GetFirst()
	local tc2=Duel.GetFirstTarget()
	if tc1:IsFaceup() and tc2 and tc2:IsRelateToEffect(e) and tc2:IsFaceup() then
		Duel.DoBattle(tc1,tc2)
	end
end
