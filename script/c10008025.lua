--Rampaging Tatsurion
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON,RACE_BEAST_KIN)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	aux.AddNameCategory(c,NAMECAT_TATSURION)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--banish
	aux.AddSingleTriggerEffectWinBattle(c,0,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--banish
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local pwr=Duel.GetAttackTarget():GetPreviousPowerOnField()
	e:SetLabel(pwr)
	return true
end
function scard.banfilter(c,pwr)
	return c:IsFaceup() and c:GetPower()<pwr and c:KJIsBanishable()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local pwr=e:GetLabel()
	if chkc then return chkc:IsLocation(LOCATION_BZONE) and chkc:IsControler(1-tp) and scard.banfilter(chkc,pwr) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISH)
	Duel.SelectTarget(tp,scard.banfilter,tp,0,LOCATION_BZONE,1,1,nil,pwr)
end
scard.op1=aux.TargetCardsOperation(Duel.KJBanish,REASON_EFFECT)
