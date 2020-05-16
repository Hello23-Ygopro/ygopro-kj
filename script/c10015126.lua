--Daunting Presence
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
function scard.cfilter(c)
	return c:IsFaceup() and c:GetPower()>0
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.cfilter,tp,LOCATION_BZONE,0,nil)
	if g:GetCount()==0 then return end
	local ag=Group.CreateGroup()
	local power_list={}
	for tc in aux.Next(g) do
		local pwr=tc:GetPower()
		if not ag:IsExists(Card.IsPower,1,nil,pwr) then
			ag:AddCard(tc)
			table.insert(power_list,pwr)
		end
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ANNOUNCEPOWER)
	local an=Duel.AnnounceNumber(tp,table.unpack(power_list))
	local reset_count=(Duel.GetTurnPlayer()==tp and 2 or 1)
	local c=e:GetHandler()
	--cannot attack player
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK_PLAYER)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetTarget(scard.tg1)
	e2:SetTargetRange(0,LOCATION_BZONE)
	e2:SetLabel(an)
	e2:SetLabelObject(e1)
	e2:SetReset(RESET_PHASE+PHASE_DRAW,reset_count)
	Duel.RegisterEffect(e2,tp)
end
--cannot attack player
function scard.tg1(e,c)
	return c:GetPower()<e:GetLabel()
end
