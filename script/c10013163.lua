--Change-o-bot Glu-urrgle
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	aux.AddNameCategory(c,NAMECAT_GLUURRGLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_WATER))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--unleash (confirm deck - to hand)
	aux.EnableUnleash(c,0,aux.CheckDeckFunction(PLAYER_SELF),scard.op1)
end
--unleash (confirm deck - to hand)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if ct==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ANNOUNCENAME)
	local code=Duel.AnnounceCard(tp)
	local g1=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_DECK,0,nil,code)
	local hg=Group.CreateGroup()
	local seq=-1
	for tc1 in aux.Next(g1) do
		if tc1:GetSequence()>seq then
			seq=tc1:GetSequence()
		end
	end
	Duel.ConfirmDecktop(tp,ct-seq)
	local g2=Duel.GetDecktopGroup(tp,ct-seq)
	for tc2 in aux.Next(g2) do
		if tc2:IsAbleToHand() then hg:AddCard(tc2) end
	end
	if hg:GetCount()==0 then return end
	Duel.DisableShuffleCheck()
	Duel.SendtoHand(hg,PLAYER_OWNER,REASON_EFFECT)
	Duel.ShuffleHand(tp)
end
