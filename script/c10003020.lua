--Rally the Reserves
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--ignore guard
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IGNORE_GUARD)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsHasEffect,EFFECT_GUARD))
	e2:SetTargetRange(LOCATION_BZONE,0)
	e2:SetLabelObject(e1)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
	--ignore skirmisher
	local e3=e1:Clone()
	e3:SetDescription(aux.Stringid(sid,2))
	e3:SetCode(EFFECT_IGNORE_SKIRMISHER)
	local e4=e2:Clone()
	e4:SetTarget(aux.TargetBoolFunction(Card.IsHasEffect,EFFECT_SKIRMISHER))
	e4:SetLabelObject(e3)
	Duel.RegisterEffect(e4,tp)
end
--[[
	Rulings
	Q: Do my creatures actually lose "Guard" or "Skirmisher"?
		A: No, your creatures will still have those abilities. You'll just ignore them when choosing your attacking
		creatures.
	https://kaijudo.fandom.com/wiki/Rally_the_Reserves/Rulings
]]
