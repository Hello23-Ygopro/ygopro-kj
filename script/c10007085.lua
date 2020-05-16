--Suncloak Protector
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION,RACE_COLOSSUS)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--cannot be attacked
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_BZONE)
	e1:SetTargetRange(0,LOCATION_BZONE)
	e1:SetCondition(aux.SelfTappedCondition)
	e1:SetValue(scard.val1)
	c:RegisterEffect(e1)
end
--cannot be attacked
function scard.val1(e,c)
	return c~=e:GetHandler()
end
