--Prism Blade the Ascendant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ENFORCER)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_LIGHT))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--untap, get ability
	aux.AddTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1,nil,scard.con1)
	if not scard.global_check then
		scard.global_check=true
		scard[0]=0
		scard[1]=0
		--check attacking creature
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ATTACK_ANNOUNCE)
		ge1:SetOperation(scard.checkop1)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ATTACK_DISABLED)
		ge2:SetOperation(scard.checkop2)
		Duel.RegisterEffect(ge2,0)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge3:SetOperation(scard.clearop)
		Duel.RegisterEffect(ge3,0)
	end
end
--check attacking creature
function scard.checkop1(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:GetFlagEffect(sid)==0 then
		scard[tc:GetControler()]=scard[tc:GetControler()]+1
		tc:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
	end
end
function scard.checkop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	scard[tc:GetControler()]=scard[tc:GetControler()]-1
end
function scard.clearop(e,tp,eg,ep,ev,re,r,rp)
	scard[0]=0
	scard[1]=0
end
--untap, get ability
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc:IsControler(1-tp) and Duel.GetAttackTarget()==nil and scard[tc:GetControler()]==0 and tc:GetFlagEffect(sid)==0
end
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToUntap()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.posfilter,tp,LOCATION_BZONE,0,1,e:GetHandler()) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
	local g=Duel.SelectMatchingCard(tp,scard.posfilter,tp,LOCATION_BZONE,0,1,1,c)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.Untap(g,REASON_EFFECT)
	--blocker
	aux.AddTempEffectBlocker(c,g:GetFirst(),1)
end
