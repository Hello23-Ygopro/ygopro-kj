--Lightning Legionnaire
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STORM_PATROL,RACE_STOMPER)
	--creature
	aux.EnableCreatureAttribute(c)
	--choose one (get ability or untap)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1)
end
--choose one (get ability or untap)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local opt=Duel.SelectOption(tp,aux.Stringid(sid,1),aux.Stringid(sid,2))+1
	e:SetLabel(opt)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	local c=e:GetHandler()
	if opt==1 then
		--fast attack
		aux.AddTempEffectCustom(c,c,4,EFFECT_FAST_ATTACK)
	elseif opt==2 then
		--untap
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(sid,3))
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetOperation(scard.op2)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
--untap
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToUntap()
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.posfilter,tp,LOCATION_BZONE,0,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_UNTAP)
	local sg=g:Select(tp,1,1,nil)
	Duel.HintSelection(sg)
	Duel.Untap(sg,REASON_EFFECT)
end
