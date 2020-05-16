--Worldwaker Omgoth
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_AQUAN,RACE_COLOSSUS)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter,scard.evofilter)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
	--to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
	--draw
	aux.AddSingleTriggerEffect(c,1,EVENT_BATTLE_CONFIRM,nil,nil,scard.op2,nil,aux.AttackPlayerCondition)
end
--vortex evolution
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATIONS_WN)
--to mana zone
scard.tg1=aux.CheckCardFunction(Card.IsAbleToMZone,LOCATION_HAND,0)
scard.op1=aux.SendtoMZoneOperation(PLAYER_SELF,nil,LOCATION_HAND,0)
--draw
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	Duel.DrawUpTo(tp,5-ct,REASON_EFFECT)
end
