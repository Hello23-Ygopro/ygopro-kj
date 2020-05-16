--Twilight Commander
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--untap
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1)
end
--untap
function scard.posfilter(c,pwr)
	return c:IsFaceup() and c:GetPower()<pwr and c:IsAbleToUntap()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.posfilter,tp,LOCATION_BZONE,0,1,nil,e:GetHandler():GetPower()) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_UNTAP)
	local g=Duel.SelectMatchingCard(tp,scard.posfilter,tp,LOCATION_BZONE,0,1,1,nil,e:GetHandler():GetPower())
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.Untap(g,REASON_EFFECT)
end
