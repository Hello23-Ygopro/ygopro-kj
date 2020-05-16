--Victory Gunner
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STOMPER,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_STOMPER,RACE_BEAST_KIN))
	--untap
	aux.AddSingleTriggerEffect(c,0,EVENT_CHANGE_POS,nil,nil,aux.SelfUntapOperation,nil,scard.con1)
	--to mana zone
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e0:SetCode(EVENT_CHANGE_POS)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e0:SetRange(LOCATION_BZONE)
	e0:SetOperation(scard.regop1)
	c:RegisterEffect(e0)
	aux.AddSingleTriggerEffect(c,1,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1)
end
--untap
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetFlagEffect(sid)==0 and c:IsLocation(LOCATION_BZONE) and c:IsTapped()
end
--to mana zone
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsTapped() then
		c:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
	end
end
scard.tg1=aux.DecktopSendtoMZoneTarget(PLAYER_SELF)
scard.op1=aux.DecktopSendtoMZoneOperation(PLAYER_SELF,1)
