--King Tritonus
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MONARCH,RACE_LEVIATHAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.DrawUpToOperation(PLAYER_SELF,5))
	--get ability
	aux.AddTriggerEffectPlayerCastSpell(c,1,PLAYER_SELF,nil,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--power up
	aux.EnableUpdatePower(c,4000,nil,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf(Card.IsCivilization,CIVILIZATION_WATER))
end
--get ability
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,Card.IsFaceup,0,LOCATION_BZONE,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not tc:IsFaceup() then return end
	local c=e:GetHandler()
	local reset_count=(Duel.GetTurnPlayer()==tp and 2 or 1)
	--cannot attack
	aux.AddTempEffectCustom(c,tc,2,EFFECT_CANNOT_ATTACK,RESET_PHASE+PHASE_DRAW,reset_count)
	--cannot block
	aux.AddTempEffectCustom(c,tc,3,EFFECT_CANNOT_BLOCK,RESET_PHASE+PHASE_DRAW,reset_count)
end
