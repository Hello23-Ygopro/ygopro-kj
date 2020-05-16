--Arachnomech
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STOMPER,RACE_MEGABUG)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter,scard.evofilter)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to battle zone, get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
end
--vortex evolution
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATIONS_FN)
--to battle zone, get ability
function scard.tbfilter(c,e,tp)
	return c:IsCreature() and not c:IsEvolution() and c:IsManaCostBelow(5) and c:IsAbleToBZone(e,0,tp,false,false)
end
scard.tg1=aux.SendtoBZoneTarget(aux.ManaZoneFilter(scard.tbfilter),LOCATION_MZONE,0)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
	local tc=Duel.SelectMatchingCard(tp,aux.ManaZoneFilter(scard.tbfilter),tp,LOCATION_MZONE,0,1,1,nil,e,tp):GetFirst()
	if not tc or not Duel.SendtoBZoneStep(tc,0,tp,tp,false,false,POS_FACEUP_UNTAPPED) then return end
	Duel.HintSelection(Group.FromCards(tc))
	--fast attack
	aux.AddTempEffectCustom(e:GetHandler(),tc,1,EFFECT_FAST_ATTACK)
	Duel.SendtoBZoneComplete()
end
