--King Alboran
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LEVIATHAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--confirm deck
	aux.AddTriggerEffect(c,0,EVENT_UNTAP_STEP,true,aux.CheckDeckFunction(PLAYER_SELF),scard.op1,nil,aux.TurnPlayerCondition(PLAYER_SELF))
	--return
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_BZONE)
	e1:SetOperation(scard.regop1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_BZONE)
	e2:SetOperation(scard.regop2)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(sid,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_CHAIN_END)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_BZONE)
	e3:SetCondition(scard.con1)
	e3:SetTarget(scard.tg1)
	e3:SetOperation(aux.TargetSendtoHandOperation)
	c:RegisterEffect(e3)
	e1:SetLabelObject(e3)
	e2:SetLabelObject(e3)
	local g=Group.CreateGroup()
	g:KeepAlive()
	e3:SetLabelObject(g)
end
--confirm deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local g=Duel.GetDecktopGroup(tp,1)
	Duel.ConfirmCards(tp,g)
	if Duel.SelectYesNo(tp,YESNOMSG_TODECKBOT) then
		Duel.MoveSequence(g:GetFirst(),SEQ_DECK_BOTTOM)
	end
end
--return
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetLabel(0)
end
function scard.regop2(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if rp==1-tp or not rc:IsSpell() then return end
	e:GetLabelObject():SetLabel(1)
	e:GetLabelObject():GetLabelObject():AddCard(rc)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabel()==1
end
function scard.thfilter(c,cost)
	return c:IsFaceup() and c:IsManaCost(cost) and c:IsAbleToHand()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=e:GetLabelObject()
	local cost=g:GetFirst():GetManaCost()
	if chkc then return chkc:IsLocation(LOCATION_BZONE) and scard.thfilter(chkc,cost) end
	if chk==0 then return Duel.IsExistingTarget(scard.thfilter,tp,LOCATION_BZONE,LOCATION_BZONE,1,nil,cost) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	Duel.SelectTarget(tp,scard.thfilter,tp,LOCATION_BZONE,LOCATION_BZONE,1,1,nil,cost)
	g:Clear()
end
