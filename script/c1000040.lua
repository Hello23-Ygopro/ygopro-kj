--Reckoning
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local reset_count=(Duel.GetTurnPlayer()==tp and 2 or 1)
	local c=e:GetHandler()
	--wins all battles
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(aux.WinsAllBattlesCondition)
	e1:SetOperation(aux.WinsAllBattlesOperation)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetTargetRange(LOCATION_BZONE,0)
	e2:SetLabelObject(e1)
	e2:SetReset(RESET_PHASE+PHASE_DRAW,reset_count)
	Duel.RegisterEffect(e2,tp)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(sid,2))
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_WINS_ALL_BATTLES)
	e3:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	local e4=e2:Clone()
	e4:SetLabelObject(e3)
	Duel.RegisterEffect(e4,tp)
end
