--Rampage
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--get ability
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
	local tc=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,1,1,nil):GetFirst()
	if not tc then return end
	Duel.HintSelection(Group.FromCards(tc))
	local c=e:GetHandler()
	--break
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_BANISHING)
	e1:SetCondition(aux.SelfBattleWinCondition)
	e1:SetTarget(aux.HintTarget)
	e1:SetOperation(aux.BreakOperation(tp,1-tp,1,1,c))
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(sid,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_CUSTOM+EVENT_WIN_BATTLE)
	e2:SetTarget(aux.HintTarget)
	e2:SetOperation(aux.BreakOperation(tp,1-tp,1,1,c))
	e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	tc:RegisterEffect(e2)
end
