--Vang, the Restless Plague
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_VOID_SPAWN,RACE_SHADOW_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--get ability
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,Card.IsFaceup,0,LOCATION_BZONE,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc1=Duel.GetFirstTarget()
	if tc1 and tc1:IsRelateToEffect(e) and tc1:IsFaceup() then
		--power down
		aux.AddTempEffectUpdatePower(e:GetHandler(),tc1,1,-3000)
	end
	if not Duel.IsPlayerCanClash(tp) or not Duel.SelectYesNo(tp,YESNOMSG_CLASH) then return end
	Duel.BreakEffect()
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_BZONE,nil)
	if not Duel.Clash(tp) or g:GetCount()==0 then return end
	for tc2 in aux.Next(g) do
		--power down
		aux.AddTempEffectUpdatePower(e:GetHandler(),tc2,2,-1000)
	end
end
