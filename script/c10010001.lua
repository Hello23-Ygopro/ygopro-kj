--Arc Ward
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	--untap
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_BZONE)
	e1:SetCountLimit(1)
	e1:SetOperation(scard.op2)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	g:GetFirst():RegisterEffect(e1)
end
--untap
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsAbleToUntap() then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Untap(c,REASON_EFFECT)
	local reset_count=(Duel.GetTurnPlayer()==tp and 2 or 1)
	--blocker
	aux.AddTempEffectBlocker(c,c,2,RESET_PHASE+PHASE_DRAW,reset_count)
end
--[[
	References
	* W Nebula Meteorite
	https://github.com/Fluorohydride/ygopro-scripts/blob/db63e8c/c90075978.lua#L23
]]
