--Krotork the Mirror
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TSUNAMI_DRAGON,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--vortex evolution
	aux.EnableEffectCustom(c,EFFECT_VORTEX_EVOLUTION)
	aux.AddEvolutionProcedure(c,scard.evofilter,scard.evofilter)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--cast for free
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_BZONE)
	e1:SetOperation(scard.regop1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_BZONE)
	e2:SetOperation(scard.regop2)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(sid,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_CHAIN_END)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_BZONE)
	e3:SetCondition(scard.con1)
	e3:SetOperation(scard.op1)
	c:RegisterEffect(e3)
	e1:SetLabelObject(e3)
	e2:SetLabelObject(e3)
	local g=Group.CreateGroup()
	g:KeepAlive()
	e3:SetLabelObject(g)
end
--vortex evolution
scard.evofilter=aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATIONS_WF)
--cast for free
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetLabel(0)
end
function scard.regop2(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if rp==1-tp or not rc:IsSpell() or not rc:IsLocation(LOCATION_HAND) then return end
	if re:IsHasCategory(CATEGORY_SHIELD_BLAST) and rc:IsLocation(LOCATION_HAND) then return end
	e:GetLabelObject():SetLabel(1)
	e:GetLabelObject():GetLabelObject():AddCard(rc)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabel()==1
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	Duel.CastFree(g)
	g:Clear()
end
--[[
	Rulings
		Q: Does "Reimage" affect spells I cast using "Shield Blast"?
		A: No. When you cast a spell using "Shield Blast," it isn't cast from your hand.
		http://kaijudo.wikia.com/wiki/Krotork_the_Mirror/Rulings
]]
