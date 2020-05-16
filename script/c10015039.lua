--Emperor Palata
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD,RACE_EARTH_EATER)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter,scard.evofilter)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--unleash (to hand)
	aux.EnableUnleash(c,0,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
--vortex evolution
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_WATER)
--unleash (to hand)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local g=Duel.GetDecktopGroup(tp,3)
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g:FilterSelect(tp,Card.IsAbleToHand,2,2,nil)
	g:Sub(sg)
	if sg:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
		Duel.ShuffleHand(tp)
	end
	if g:GetCount()>0 then
		aux.SortDeck(tp,tp,3-sg:GetCount(),SEQ_DECK_BOTTOM)
	end
end
--[[
	References
		1. Scrutinize
]]
