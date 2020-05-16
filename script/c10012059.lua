--Humonguru
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CORRUPTED,RACE_ENFORCER,RACE_MEGABUG,RACE_HUMAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--tap, get ability
	aux.AddTriggerEffectEnterMZone(c,0,PLAYER_SELF,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER,scard.con1)
	aux.AddEffectDescription(c,2,scard.con1)
end
--tap, get ability
function scard.posfilter(c)
	return c:IsFaceup() and c:IsAbleToTap()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_BZONE) and chkc:IsControler(1-tp) and scard.posfilter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TAP)
	Duel.SelectTarget(tp,scard.posfilter,tp,0,LOCATION_BZONE,eg:GetCount(),eg:GetCount(),nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
		Duel.Tap(g,REASON_EFFECT)
	end
	local c=e:GetHandler()
	if not c:IsFaceup() then return end
	--power up
	aux.AddTempEffectUpdatePower(c,c,1,3000)
end
--triple breaker
function scard.con1(e)
	return e:GetHandler():IsPowerAbove(12000)
end
