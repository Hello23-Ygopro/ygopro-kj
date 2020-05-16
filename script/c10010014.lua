--Veil Slip
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--to battle zone, return
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
	if not scard.global_check then
		scard.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_CHAIN_SOLVED)
		ge1:SetOperation(scard.regop1)
		Duel.RegisterEffect(ge1,0)
	end
end
--to battle zone, return
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_COME_INTO_PLAY) then return end
	--raise event when "When this creature enters the battle zone" resolves
	Duel.RaiseSingleEvent(re:GetHandler(),EVENT_CUSTOM+sid,e,0,0,0,0)
end
function scard.tbfilter(c,e,tp)
	return c:IsCreature() and not c:IsEvolution() and c:IsManaCostBelow(8) and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
	local g=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()==0 or Duel.SendtoBZone(g,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)==0 then return end
	local tc=Duel.GetOperatedGroup():GetFirst()
	if not tc:IsLocation(LOCATION_BZONE) then return end
	--return
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+sid)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetOperation(scard.op2)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	tc:RegisterEffect(e1)
end
--return
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoHand(e:GetHandler(),PLAYER_OWNER,REASON_EFFECT)
end
