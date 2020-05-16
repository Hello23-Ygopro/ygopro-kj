--Guacamole Gunner
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_WILD_VEGGIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--banish, to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,aux.SelfBanishTarget,scard.op1)
end
--banish, to mana zone
function scard.tmfilter(c,e)
	return c:IsFaceup() and c:IsUntapped() and c:IsAbleToMZone() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or Duel.KJBanish(c,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOMZONE)
	local g=Duel.SelectMatchingCard(tp,scard.tmfilter,tp,0,LOCATION_BZONE,1,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.SendtoMZone(g,POS_FACEUP_UNTAPPED,REASON_EFFECT)
end
