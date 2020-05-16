--Grand Manipulator Agaryx
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TERROR_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to battle zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
	--get ability, banish
	aux.AddSingleTriggerEffect(c,1,EVENT_ATTACK_ANNOUNCE,nil,nil,scard.op2)
end
--to battle zone
function scard.tbfilter(c,e,tp,cost)
	return c:IsCreature() and c:IsManaCostAbove(0) and c:IsManaCostBelow(cost) and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local cost=6
	local g=Duel.GetMatchingGroup(aux.KJDPileFilter(scard.tbfilter),tp,LOCATION_DPILE,0,nil,e,tp,cost)
	local pg=Group.CreateGroup()
	repeat
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
		local tc=g:Select(tp,0,1,nil):GetFirst()
		if not tc then break end
		pg:AddCard(tc)
		cost=cost-tc:GetManaCost()
		g=g:Filter(scard.tbfilter,nil,e,tp,cost)
	until cost<=0 or g:GetCount()==0 or Duel.GetLocationCount(tp,LOCATION_BZONE)<=0
	Duel.SendtoBZone(pg,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
end
--get ability, banish
function scard.banfilter(c)
	return c:IsFaceup() and c:KJIsBanishable()
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=Duel.GetMatchingGroupCount(scard.banfilter,tp,LOCATION_BZONE,0,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISH)
	local g=Duel.SelectMatchingCard(tp,scard.banfilter,tp,LOCATION_BZONE,0,0,ct,c)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.KJBanish(g,REASON_EFFECT)
	--power up
	aux.AddTempEffectUpdatePower(c,c,2,g:GetCount()*5000)
	--break extra shield
	aux.AddTempEffectCustom(c,c,3,EFFECT_BREAK_EXTRA_SHIELD)
end
