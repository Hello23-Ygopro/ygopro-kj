--Galvanize
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,0,2,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	local c=e:GetHandler()
	for tc in aux.Next(g) do
		--power up
		aux.AddTempEffectUpdatePower(c,tc,2,1000)
		--untap
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(sid,1))
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetRange(LOCATION_BZONE)
		e1:SetCountLimit(1)
		e1:SetOperation(scard.op2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
--untap
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsAbleToUntap() then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Untap(c,REASON_EFFECT)
end
