--Cyber Walker Kaylee
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD,RACE_STOMPER)
	--creature
	aux.EnableCreatureAttribute(c)
	--powerful attack
	aux.EnablePowerfulAttack(c,2000)
	--get ability
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_COME_INTO_PLAY)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--banish replace (return)
	aux.AddSingleReplaceEffectBanish(c,1,scard.tg1,scard.op2)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	local c=e:GetHandler()
	--turn attack tapped
	aux.AddTempEffectCustom(c,c,2,EFFECT_TURN_ATTACK_TAPPED)
end
--banish replace (return)
scard.tg1=aux.SingleReplaceBanishTarget(Card.IsAbleToHand)
scard.op2=aux.SingleReplaceBanishOperation(Duel.SendtoHand,PLAYER_OWNER,REASON_EFFECT+REASON_REPLACE)
