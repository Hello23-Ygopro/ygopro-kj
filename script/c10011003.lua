--Krakatoa the Shattered
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON,RACE_LIVING_CITY)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--to battle zone, get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
end
--to battle zone, get ability
function scard.tbfilter1(c)
	return c:IsCreature() and not c:IsEvolution() and c:IsManaCostBelow(4)
end
scard.tg1=aux.SendtoBZoneTarget(scard.tbfilter1,LOCATION_HAND,0)
function scard.tbfilter2(c,e,tp)
	return scard.tbfilter1(c) and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
	local tc=Duel.SelectMatchingCard(tp,scard.tbfilter2,tp,LOCATION_HAND,0,1,1,nil,e,tp):GetFirst()
	if not tc or not Duel.SendtoBZoneStep(tc,0,tp,tp,false,false,POS_FACEUP_UNTAPPED) then return end
	local c=e:GetHandler()
	--fast attack
	aux.AddTempEffectCustom(c,tc,2,EFFECT_FAST_ATTACK)
	--to mana zone
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_BZONE)
	e1:SetCountLimit(1)
	e1:SetOperation(scard.op2)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	tc:RegisterEffect(e1)
	Duel.SendtoBZoneComplete()
end
--to mana zone
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsAbleToMZone() then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.SendtoMZone(c,POS_FACEUP_UNTAPPED,REASON_EFFECT)
end
