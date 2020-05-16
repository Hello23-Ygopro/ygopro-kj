--Ironwill Tree
--Not fully implemented: Prevents discarding from both players' spells and abilities
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STAR_SENTINEL)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--skirmisher
	aux.EnableSkirmisher(c)
	--cannot discard
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_DISCARD_HAND)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_BZONE)
	e1:SetTargetRange(1,0)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
