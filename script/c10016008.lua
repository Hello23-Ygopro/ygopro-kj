--Hoverstar
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_FRACTAL)
	--creature
	aux.EnableCreatureAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--blocker
	aux.EnableBlocker(c)
	--skirmisher
	aux.EnableSkirmisher(c)
	--untap
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e0:SetCode(EVENT_CHANGE_POS)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e0:SetRange(LOCATION_BZONE)
	e0:SetOperation(scard.regop1)
	c:RegisterEffect(e0)
	aux.AddSingleTriggerEffect(c,0,EVENT_CHANGE_POS,nil,nil,scard.op1,nil,scard.con1)
end
--untap
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsTapped() then
		c:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
	end
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetFlagEffect(sid)==0 and c:IsLocation(LOCATION_BZONE) and c:IsTapped()
end
function scard.posfilter(c)
	return c:IsFaceup() and c:IsHasEffect(EFFECT_BLOCKER) and c:IsAbleToUntap()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.posfilter,tp,LOCATION_BZONE,0,e:GetHandler())
	Duel.Untap(g,REASON_EFFECT)
end
