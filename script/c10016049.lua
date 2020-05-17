--Torchwake Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--get ability
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_COME_INTO_PLAY)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--to deck
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,aux.SendtoDeckOperation(PLAYER_SELF,nil,LOCATION_HAND,0,1,1,SEQ_DECK_TOP))
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	local c=e:GetHandler()
	--turn attack tapped
	aux.AddTempEffectCustom(c,c,2,EFFECT_TURN_ATTACK_TAPPED)
end