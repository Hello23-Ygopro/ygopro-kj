--Beastlord Rulchor
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_NATURE))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--unleash (to battle, to hand)
	aux.EnableUnleash(c,0,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
--unleash (to battle, to hand)
function scard.tbfilter(c,e,tp)
	return c:IsCreature() and not c:IsEvolution() and c:IsManaCostBelow(3) and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.thfilter(c)
	return c:IsCreature() and c:IsEvolution() and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local g=Duel.GetDecktopGroup(tp,5)
	Duel.ConfirmCards(tp,g)
	local bzone_count=Duel.GetLocationCount(tp,LOCATION_BZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
	local sg1=g:FilterSelect(tp,scard.tbfilter,0,bzone_count,nil,e,tp)
	if sg1:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.SendtoBZone(sg1,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
		g:Sub(sg1)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg2=g:FilterSelect(tp,scard.thfilter,0,1,nil)
	if sg2:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(sg2,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg2)
		Duel.ShuffleHand(tp)
		g:Sub(sg2)
	end
	if g:GetCount()>0 then
		aux.SortDeck(tp,tp,5-sg1:GetCount()-sg2:GetCount(),SEQ_DECK_BOTTOM)
	end
end
