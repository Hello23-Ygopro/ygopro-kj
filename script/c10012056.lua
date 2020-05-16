--The Mystic of Light
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MYSTIC)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.SendtoHandOperation(PLAYER_SELF,aux.KJDPileFilter(scard.retfilter),LOCATION_DPILE,0,1))
	--win game
	aux.AddTriggerEffect(c,1,EVENT_PHASE+PHASE_END,nil,nil,scard.op1,nil,scard.con1)
end
--return
function scard.retfilter(c)
	return c:IsSpell() and c:IsCivilization(CIVILIZATION_LIGHT)
end
--win game
function scard.cfilter(c)
	return c:IsFaceup() and c:KJIsRace(RACE_MYSTIC)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.cfilter,tp,LOCATION_BZONE,0,nil)
	return Duel.GetTurnPlayer()==tp
		and g:GetCount()>=CIVILIZATION_COUNT and g:GetClassCount(Card.GetCivilization)==CIVILIZATION_COUNT
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Win(tp,WIN_REASON_MYSTIC_LIGHT)
end
