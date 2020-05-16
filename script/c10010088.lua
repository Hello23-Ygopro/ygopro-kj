--Elder Titan Auralia
--WORK IN PROGRESS: The destination of the card in the deck is not properly checked
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION,RACE_COLOSSUS)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_SKYFORCE_CHAMPION,RACE_COLOSSUS))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--send replace (cast for free)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_SEND_REPLACE)
	e1:SetTarget(scard.tg1)
	e1:SetOperation(scard.op1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetRange(LOCATION_BZONE)
	e2:SetTargetRange(LOCATION_DECK,0)
	e2:SetTarget(scard.tg2)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
--send replace (cast for free)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetDestination()==LOCATION_MZONEUNT end
	if Duel.SelectYesNo(tp,aux.Stringid(sid,1)) then
		return true
	else return false end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.CastFree(e:GetHandler())
end
function scard.tg2(e,c)
	return c:IsSpell() and c:IsManaCostBelow(7)
end
--[[
function scard.repfilter(c,tp)
	return c:IsSpell() and c:IsManaCostBelow(7) and c:IsControler(tp)
		and c:GetLocation()==LOCATION_DECK and c:GetDestination()==LOCATION_MZONEUNT
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(scard.repfilter,1,nil,tp) end
	local g=eg:Filter(scard.repfilter,nil,tp)
	if Duel.SelectYesNo(tp,aux.Stringid(sid,1)) then
		g:KeepAlive()
		e:SetLabelObject(g)
		return true
	else return false end
end
function scard.val1(e,c)
	return scard.repfilter(c,e:GetHandlerPlayer())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.CastFree(e:GetLabelObject())
end
]]
