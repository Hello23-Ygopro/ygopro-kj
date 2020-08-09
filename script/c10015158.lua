--Taksha, Scourge Gunner
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SHADOW_CHAMPION,RACE_BERSERKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter,scard.evofilter)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--discard, draw
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,aux.CheckCardFunction(aux.TRUE,LOCATION_HAND,0),scard.op1)
	--get ability (power down)
	aux.AddTriggerEffect(c,1,EVENT_DISCARD,nil,scard.tg1,aux.TargetUpdatePowerOperation(2,-1000),EFFECT_FLAG_CARD_TARGET)
end
--vortex evolution
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATIONS_DF)
--discard, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.DiscardHand(tp,aux.TRUE,1,1,REASON_EFFECT)>0 then
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end
--get ability (power down)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_BZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_BZONE,eg:GetCount(),eg:GetCount(),nil)
end
--[[
	Rulings
	Q: If I don't have any cards in my hand, can I just draw a card?
		A: No.
	https://kaijudo.fandom.com/wiki/Mischievous_Fire-Chick/Rulings
]]
