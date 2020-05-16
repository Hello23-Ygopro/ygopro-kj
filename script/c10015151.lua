--Cetus the Augur
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CELESTIAL_DRAGON,RACE_LEVIATHAN)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter,scard.evofilter)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to hand, to shield zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--vortex evolution
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATIONS_LW)
--to hand, to shield zone
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local g=Duel.GetDecktopGroup(tp,2)
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g:FilterSelect(tp,Card.IsAbleToHand,1,1,nil)
	g:Sub(sg)
	Duel.DisableShuffleCheck()
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
		Duel.ShuffleHand(tp)
	end
	if g:GetCount()>0 then
		Duel.SendtoSZone(g)
	end
end
--[[
	References
		1. Reap and Sow
]]
