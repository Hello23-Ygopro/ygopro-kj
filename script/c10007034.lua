--Gregoria's Fortress
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--banish
	aux.AddSingleTriggerEffect(c,0,EVENT_BANISHED,nil,nil,aux.BanishOperation(PLAYER_OPPO,Card.IsFaceup,0,LOCATION_BZONE,1))
	aux.AddTriggerEffect(c,0,EVENT_BANISHED,nil,nil,scard.op1,nil,aux.LeaveBZoneCondition(PLAYER_SELF))
end
--banish
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	aux.BanishOperation(1-tp,Card.IsFaceup,0,LOCATION_BZONE,eg:GetCount())(e,tp,eg,ep,ev,re,r,rp)
end
