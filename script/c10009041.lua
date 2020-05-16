--Calamity Bell
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--discard, tap
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--discard, tap
function scard.posfilter(c,cost)
	return c:IsFaceup() and c:IsManaCostBelow(cost) and c:IsAbleToTap()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.RandomDiscardHand(1-tp,1,REASON_EFFECT)==0 then return end
	local tc=Duel.GetOperatedGroup():GetFirst()
	local cost=tc:GetManaCost()
	local g=Duel.GetMatchingGroup(scard.posfilter,tp,0,LOCATION_BZONE,nil,cost)
	Duel.Tap(g,REASON_EFFECT)
end
