--King Poseidon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LEVIATHAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--return
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_BANISHED)
	e1:SetRange(LOCATION_BZONE)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_CUSTOM+EVENT_LOSE_BATTLE)
	e2:SetCondition(scard.con2)
	c:RegisterEffect(e2)
end
--return
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(aux.FilterEqualFunction(Card.GetPreviousControler,tp),1,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst():GetBattleTarget()
	if tc:IsRelateToBattle() then
		Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)
	end
end
function scard.con2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsControler,1,nil,tp)
end
--[[
	References
	* Kaiser Vorse Raider
	https://github.com/Fluorohydride/ygopro-scripts/blob/2c4f0ca/c93927067.lua#L48
]]
