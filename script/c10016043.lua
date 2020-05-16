--Pyrotech Warrior
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_VOID_SPAWN,RACE_BERSERKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--clash (banish)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--clash (banish)
scard.tg1=aux.ClashTarget(PLAYER_SELF)
function scard.banfilter(c,e)
	return c:IsFaceup() and c:IsPowerBelow(2000) and c:KJIsBanishable() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.Clash(tp) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISH)
	local g=Duel.SelectMatchingCard(tp,scard.banfilter,tp,0,LOCATION_BZONE,1,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.KJBanish(g,REASON_EFFECT)
end
