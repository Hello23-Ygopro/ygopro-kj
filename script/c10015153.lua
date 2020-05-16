--Brave Shalloteer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STORM_PATROL,RACE_WILD_VEGGIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--cannot be blocked
	aux.EnableCannotBeBlocked(c,aux.CannotBeBlockedLessPowerValue)
end
--cannot be blocked
function scard.posfilter(c,pwr)
	return c:IsFaceup() and c:GetPower()<pwr and c:IsAbleToTap()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local pwr=e:GetHandler():GetPower()
	if chkc then return chkc:IsLocation(LOCATION_BZONE) and chkc:IsControler(1-tp) and scard.posfilter(chkc,pwr) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TAP)
	Duel.SelectTarget(tp,scard.posfilter,tp,0,LOCATION_BZONE,1,1,nil,pwr)
end
scard.op1=aux.TargetCardsOperation(Duel.Tap,REASON_EFFECT)
