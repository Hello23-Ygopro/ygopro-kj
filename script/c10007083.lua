--Oathsworn Call
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--to battle zone, get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--to battle zone, get ability
function scard.tbfilter(c,e,tp)
	return c:IsCreature() and not c:IsEvolution() and c:IsManaCostBelow(6) and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
	local tc=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp):GetFirst()
	if not tc or not Duel.SendtoBZoneStep(tc,0,tp,tp,false,false,POS_FACEUP_UNTAPPED) then return end
	local reset_count=(Duel.GetTurnPlayer()==tp and 2 or 1)
	--blocker
	aux.AddTempEffectBlocker(e:GetHandler(),tc,1,RESET_PHASE+PHASE_DRAW,reset_count)
	Duel.SendtoBZoneComplete()
end
