--Torhelm, Stomper Elite (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STOMPER)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_FIRE))
	--get ability
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_COME_INTO_PLAY)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--break
	aux.AddTriggerEffectBecomeTarget(c,1,nil,nil,aux.BreakOperation(PLAYER_SELF,PLAYER_OPPO,1,1,c))
end
--break
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	local c=e:GetHandler()
	--turn attack untapped
	aux.AddTempEffectCustom(c,c,2,EFFECT_TURN_ATTACK_UNTAPPED)
end
