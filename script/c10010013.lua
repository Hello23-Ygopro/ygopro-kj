--Seneschal, Choten's Lieutenant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CORRUPTED,RACE_CYBER_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw
	aux.AddTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,1),nil,scard.con1)
	--cannot be targeted
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetRange(LOCATION_BZONE)
	e1:SetTargetRange(LOCATION_BZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.KJIsRace,RACE_CORRUPTED))
	e1:SetValue(scard.val1)
	c:RegisterEffect(e1)
end
--draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc:IsControler(tp) and tc:KJIsRace(RACE_CORRUPTED)
end
--cannot be target
function scard.val1(e,re,rp)
	local rc=re:GetHandler()
	return rp==1-e:GetHandlerPlayer() and rc:IsSpell() and rc:IsManaCostBelow(4)
end
