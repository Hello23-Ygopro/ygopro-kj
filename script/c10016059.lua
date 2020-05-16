--Mana Lightning
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	--to mana zone
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op2)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
--to mana zone
function scard.con1(e)
	return Duel.GetAttacker():IsControler(e:GetHandlerPlayer())
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanSendDecktoptoMZone(tp,1) or not Duel.SelectYesNo(tp,YESNOMSG_TOMZONE) then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.SendDecktoptoMZone(tp,1,POS_FACEUP_UNTAPPED,REASON_EFFECT)
end
