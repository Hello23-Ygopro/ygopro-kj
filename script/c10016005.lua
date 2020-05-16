--Feathered Malteel
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_VOID_SPAWN,RACE_SKYFORCE_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--skirmisher
	aux.EnableSkirmisher(c)
	--clash (tap)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--clash (tap)
scard.tg1=aux.ClashTarget(PLAYER_SELF)
function scard.posfilter(c,e)
	return c:IsFaceup() and c:IsAbleToTap() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.Clash(tp) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TAP)
	local g=Duel.SelectMatchingCard(tp,scard.posfilter,tp,0,LOCATION_BZONE,1,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.Tap(g,REASON_EFFECT)
end
