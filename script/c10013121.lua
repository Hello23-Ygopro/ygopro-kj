--Allure
--WORK IN PROGRESS: See Forbidding Totem in Duel Masters
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
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	local reset_count=1
	if Duel.GetTurnPlayer()==tp then reset_count=2 end
	local c=e:GetHandler()
	--must attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MUST_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetCondition(scard.con1)
	e1:SetLabelObject(g:GetFirst())
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetTargetRange(0,LOCATION_BZONE)
	e2:SetLabelObject(e1)
	e2:SetReset(RESET_PHASE+PHASE_DRAW,reset_count)
	Duel.RegisterEffect(e2,tp)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_MUST_ATTACK_CREATURE)
	e3:SetValue(scard.val1)
	local e4=e2:Clone()
	e4:SetLabelObject(e3)
	Duel.RegisterEffect(e4,tp)
end
--must attack
function scard.con1(e)
	return e:GetLabelObject()
end
function scard.val1(e,c)
	return not c:IsImmuneToEffect(e) and c==e:GetLabelObject()
end
