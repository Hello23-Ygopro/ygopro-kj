--Thundering Clap
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--banish, get ability
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--banish, get ability
function scard.banfilter(c)
	return c:IsFaceup() and c:IsHasEffect(EFFECT_BLOCKER) and c:KJIsBanishable()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.banfilter,0,LOCATION_BZONE,1,1,HINTMSG_BANISH)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc1=Duel.GetFirstTarget()
	if tc1 and tc1:IsRelateToEffect(e) and scard.banfilter(tc1) then
		Duel.KJBanish(tc1,REASON_EFFECT)
	end
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	if g:GetCount()==0 then return end
	for tc2 in aux.Next(g) do
		--powerful attack
		aux.AddTempEffectPowerfulAttack(e:GetHandler(),tc2,1,1000)
	end
end
