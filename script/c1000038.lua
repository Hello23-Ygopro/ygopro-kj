--Snow Fort
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_COMPLEX)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--guard
	aux.EnableGuard(c)
	--get ability
	aux.AddTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	--banish
	aux.AddTriggerEffect(c,1,EVENT_ATTACK_ANNOUNCE,nil,nil,aux.SelfBanishOperation,nil,scard.con2)
end
--get ability
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(tp)
end
scard.tg1=aux.CheckCardFunction(aux.TRUE,LOCATION_HAND,0)
function scard.abfilter(c,e)
	return c:IsFaceup() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.DiscardHand(tp,aux.TRUE,1,1,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local tc=Duel.SelectMatchingCard(tp,scard.abfilter,tp,0,LOCATION_BZONE,1,1,nil,e):GetFirst()
	if not tc then return end
	Duel.SetTargetCard(tc)
	local c=e:GetHandler()
	local reset_count=(Duel.GetTurnPlayer()==tp and 2 or 1)
	--cannot attack
	aux.AddTempEffectCustom(c,tc,2,EFFECT_CANNOT_ATTACK,RESET_PHASE+PHASE_DRAW,reset_count)
	--cannot block
	aux.AddTempEffectCustom(c,tc,3,EFFECT_CANNOT_BLOCK,RESET_PHASE+PHASE_DRAW,reset_count)
end
--banish
function scard.con2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():KJIsRace(RACE_ARMORED_DRAGON,RACE_MELT_WARRIOR)
end
