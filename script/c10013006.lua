--Eternity Pulse
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--untap, get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--untap, get ability
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToUntap()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(scard.posfilter,tp,LOCATION_BZONE,0,nil)
	Duel.Untap(g1,REASON_EFFECT)
	local g2=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	if g2:GetCount()==0 then return end
	local reset_count=(Duel.GetTurnPlayer()==tp and 2 or 1)
	for tc in aux.Next(g2) do
		--blocker
		aux.AddTempEffectBlocker(e:GetHandler(),tc,1,RESET_PHASE+PHASE_DRAW,reset_count)
	end
end
