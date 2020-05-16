--Shadeblaze the Corruptor
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TERROR_DRAGON,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--get ability (power down)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--get ability
	aux.AddTriggerEffect(c,1,EVENT_BANISHED,nil,nil,scard.op2,nil,aux.LeaveBZoneCondition())
end
--get ability (power down)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,Card.IsFaceup,0,LOCATION_BZONE,1,1,HINTMSG_TARGET)
scard.op1=aux.TargetUpdatePowerOperation(2,-2000)
--get ability
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	if g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		--fast attack
		aux.AddTempEffectCustom(e:GetHandler(),tc,3,EFFECT_FAST_ATTACK)
	end
end
