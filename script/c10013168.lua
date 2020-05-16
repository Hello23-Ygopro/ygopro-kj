--Warmaster Tatsurion
--Not fully implemented: Creatures do not tap when attacking
--WORK IN PROGRESS
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON,RACE_BEAST_KIN)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	aux.AddNameCategory(c,NAMECAT_TATSURION)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_FIRE))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--unleash (untap)
	aux.EnableUnleash(c,0,nil,scard.op1)
	--[[
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_ATTACK_END_SELF_UNTAP)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op2)
	c:RegisterEffect(e1)
	]]
end
--unleash (untap)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:GetFlagEffect(sid)>0 then return end
	c:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_DAMAGE,0,1)
end
--[[
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(sid)>0
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsAbleToUntap() then return end
	Duel.Hint(HINT_CARD,0,sid)
	if Duel.Untap(c,REASON_EFFECT)==0 then return end
	c:ResetFlagEffect(sid)
end
]]
