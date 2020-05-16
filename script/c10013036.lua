--Cyber Lord Wakiki
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local reset_count=(Duel.GetTurnPlayer()~=tp and 2 or 1)
	local c=e:GetHandler()
	--do not untap
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DONOT_UNTAP_START_STEP)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetTargetRange(0,LOCATION_BZONE)
	e2:SetLabelObject(e1)
	e2:SetReset(RESET_PHASE+PHASE_DRAW,reset_count)
	Duel.RegisterEffect(e2,tp)
end
--[[
	Rulings
		Q: Will "Strong Arm" affect creatures that weren't in the battle zone when Cyber Lord Wakiki entered the battle
		zone?
		A: Yes. If your opponent somehow puts creatures into the battle zone later during the same turn that this creature
		entered the battle zone, those creatures also won't untap at the start of your opponent's next turn.
		https://kaijudo.fandom.com/wiki/Cyber_Lord_Wakiki/Rulings
]]
