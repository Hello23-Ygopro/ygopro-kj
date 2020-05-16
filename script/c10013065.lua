--Cursed Phantom
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SPECTER)
	--creature
	aux.EnableCreatureAttribute(c)
	--banish, get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
end
--banish, get ability
function scard.banfilter(c)
	return c:IsFaceup() and c:KJIsBanishable()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.banfilter,tp,LOCATION_BZONE,0,1,e:GetHandler()) end
end
function scard.powfilter(c,e)
	return c:IsFaceup() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISH)
	local g1=Duel.SelectMatchingCard(tp,scard.banfilter,tp,LOCATION_BZONE,0,1,1,c)
	if g1:GetCount()==0 then return end
	Duel.HintSelection(g1)
	if Duel.KJBanish(g1,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g2=Duel.SelectMatchingCard(tp,scard.powfilter,tp,0,LOCATION_BZONE,1,1,nil,e)
	if g2:GetCount()==0 then return end
	Duel.SetTargetCard(g2)
	--power down
	aux.AddTempEffectUpdatePower(c,g2:GetFirst(),1,-3000)
end
