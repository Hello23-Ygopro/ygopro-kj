--Underworld Stalker
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SHADOW_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--slayer
	aux.EnableSlayer(c)
	--summon from discard pile
	aux.AddSummonProcedure(c,LOCATION_DPILE)
	--redirect (to deck)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_TO_DPILE_REDIRECT)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_BZONE)
	e1:SetTarget(scard.tg1)
	e1:SetTargetRange(0,LOCATION_ALL)
	e1:SetValue(LOCATION_DECKBOT)
	c:RegisterEffect(e1)
	--prevent conflict with Kaijudo Rules
	local e2=e1:Clone()
	e2:SetCode(EFFECT_TO_MZONE_REDIRECT)
	e2:SetTarget(scard.tg2)
	e2:SetTargetRange(0,LOCATION_BZONE)
	c:RegisterEffect(e2)
end
--redirect (to deck)
function scard.tg1(e,c)
	--REASON_COST: prevent a creature from being put into the deck when a player taps it
	return c:IsCreature() and not c:IsReason(REASON_COST)
end
function scard.tg2(e,c)
	return c:IsReason(REASON_BANISH) or c:IsReason(REASON_BATTLE)
end
