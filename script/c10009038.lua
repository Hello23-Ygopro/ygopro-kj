--Striding Hearthwood
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TREE_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--banish replace (to mana zone)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLE_BANISHING)
	e1:SetCondition(aux.SelfBattleWinCondition)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_CUSTOM+EVENT_WIN_BATTLE)
	e2:SetCondition(aux.TRUE)
	c:RegisterEffect(e2)
end
--banish replace (to mana zone)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	if tc and tc:IsRelateToBattle() then
		Duel.Hint(HINT_CARD,0,sid)
		Duel.SendtoMZone(tc,POS_FACEUP_UNTAPPED,REASON_EFFECT)
	end
end
