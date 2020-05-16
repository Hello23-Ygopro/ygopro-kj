--Ulphonas, Fiendish Overlord
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_INVADER,RACE_DREAD_MASK)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter,scard.evofilter)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--banish
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.HintTarget,scard.op1,nil,scard.con1)
	--to shield zone
	aux.AddSingleTriggerEffect(c,1,EVENT_ATTACK_ANNOUNCE,nil,aux.HintTarget,scard.op2,nil,scard.con2)
end
--vortex evolution
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATIONS_LD)
--banish
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetMatchingGroupCount(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	local ct2=Duel.GetMatchingGroupCount(Card.IsFaceup,tp,0,LOCATION_BZONE,nil)
	return ct2>ct1
end
scard.op1=aux.BanishOperation(PLAYER_OPPO,Card.IsFaceup,0,LOCATION_BZONE,1)
--to shield zone
function scard.con2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetShieldCount(1-tp)>Duel.GetShieldCount(tp)
end
scard.op2=aux.DecktopSendtoSZoneOperation(PLAYER_SELF,1)
