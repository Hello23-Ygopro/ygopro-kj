--Void Primogen
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_VOID_SPAWN,RACE_SHADOW_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--clash (to battle)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,aux.ClashTarget(PLAYER_SELF),scard.op1)
end
--clash (to battle)
function scard.tbfilter(c,e,tp)
	return c:IsCreature() and not c:IsEvolution() and c:IsManaCostBelow(4) and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.Clash(tp) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
	local g=Duel.SelectMatchingCard(tp,aux.KJDPileFilter(scard.tbfilter),tp,LOCATION_DPILE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SendtoBZone(g,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
	end
end
