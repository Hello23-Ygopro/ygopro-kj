--Spark of Hunger
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	scard.powerup(e,tp,eg,ep,ev,re,r,rp)
	--power up
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_CLASH)
	e1:SetCondition(aux.EventPlayerCondition(PLAYER_SELF))
	e1:SetOperation(scard.op2)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
--power up
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	scard.powerup(e,tp,eg,ep,ev,re,r,rp)
end
function scard.powerup(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	if g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		--power up
		aux.AddTempEffectUpdatePower(e:GetHandler(),tc,2,2000)
	end
end
