--Swift Regeneration
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to battle zone, get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--to battle zone, get ability
function scard.tbfilter(c,e,tp)
	return c:IsCreature() and c:IsManaCostBelow(7) and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(aux.ManaZoneFilter(scard.tbfilter),tp,LOCATION_MZONE,0,nil,e,tp)
	local ct=g1:GetCount()
	local bzone_count=Duel.GetLocationCount(tp,LOCATION_BZONE)
	if ct>bzone_count then ct=bzone_count end
	if ct>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
		local sg=g1:Select(tp,0,ct,nil)
		if sg:GetCount()>0 then
			Duel.SendtoBZone(sg,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
		end
	end
	local reset_count=(Duel.GetTurnPlayer()==tp and 2 or 1)
	local c=e:GetHandler()
	--cannot be banished
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UNBANISHABLE)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetValue(1)
	e1:SetCondition(scard.con1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetTargetRange(LOCATION_BZONE,0)
	e2:SetLabelObject(e1)
	e2:SetReset(RESET_PHASE+PHASE_DRAW+reset_count)
	Duel.RegisterEffect(e2,tp)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_UNBANISHABLE_BATTLE)
	local e4=e2:Clone()
	Duel.RegisterEffect(e4,tp)
	local e5=e1:Clone()
	e3:SetCode(EFFECT_UNBANISHABLE_EFFECT)
	local e6=e2:Clone()
	Duel.RegisterEffect(e6,tp)
end
--cannot be banished
function scard.con1(e)
	return e:GetHandler():GetPower()>0
end
