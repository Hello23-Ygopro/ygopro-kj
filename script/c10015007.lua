--Citadel Judge
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ENFORCER)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,scard.op1)
end
--tap
function scard.posfilter(c,cost)
	return c:IsFaceup() and c:IsManaCost(cost) and c:IsAbleToTap()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_BZONE,nil)
	if g1:GetCount()==0 then return end
	local ag=Group.CreateGroup()
	local level_list={}
	for tc in aux.Next(g1) do
		local cost=tc:GetManaCost()
		if not ag:IsExists(Card.IsManaCost,1,nil,cost) then
			ag:AddCard(tc)
			table.insert(level_list,cost)
		end
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ANNOUNCECOST)
	local an=Duel.AnnounceNumber(tp,table.unpack(level_list))
	local g2=Duel.GetMatchingGroup(scard.posfilter,tp,0,LOCATION_BZONE,nil,an)
	Duel.Tap(g2,REASON_EFFECT)
end
