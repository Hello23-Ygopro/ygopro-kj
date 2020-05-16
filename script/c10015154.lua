--Radiant Blinderhorn
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION,RACE_TUSKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter,scard.evofilter)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
	--tap
	aux.AddTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--vortex evolution
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATIONS_LN)
--tap
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(tp)
end
function scard.posfilter(c,pwr)
	return c:IsFaceup() and c:GetPower()<pwr and c:IsAbleToTap()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local pwr=Duel.GetAttacker():GetPower()
	if chkc then return chkc:IsLocation(LOCATION_BZONE) and chkc:IsControler(1-tp) and scard.posfilter(chkc,pwr) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TAP)
	Duel.SelectTarget(tp,scard.posfilter,tp,0,LOCATION_BZONE,1,1,nil,pwr)
end
scard.op1=aux.TargetCardsOperation(Duel.Tap,REASON_EFFECT)
