--Fault-Line Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON,RACE_EARTHSTRIKE_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_COME_INTO_PLAY)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--to mana zone
	aux.AddSingleTriggerEffectWinBattle(c,1,true,aux.DecktopSendtoMZoneTarget(PLAYER_SELF),aux.DecktopSendtoMZoneOperation(PLAYER_SELF,1))
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	local c=e:GetHandler()
	--turn attack tapped
	aux.AddTempEffectCustom(c,c,2,EFFECT_TURN_ATTACK_TAPPED)
end
