--Squillace Scourge
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LEVIATHAN,RACE_CHIMERA)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--discard
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,aux.HintTarget,aux.DiscardOperation(nil,aux.TRUE,LOCATION_HAND,LOCATION_HAND))
	--get ability
	aux.AddSingleTriggerEffect(c,1,EVENT_COME_INTO_PLAY,nil,aux.HintTarget,scard.op1)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local reset_count=(Duel.GetTurnPlayer()==tp and 2 or 1)
	local c=e:GetHandler()
	--cannot attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetTargetRange(0,LOCATION_BZONE)
	e1:SetReset(RESET_PHASE+PHASE_DRAW,reset_count)
	Duel.RegisterEffect(e1,tp)
	--cannot block
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(sid,2))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BLOCK)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e2:SetTargetRange(0,1)
	e2:SetReset(RESET_PHASE+PHASE_DRAW,reset_count)
	Duel.RegisterEffect(e2,tp)
end
