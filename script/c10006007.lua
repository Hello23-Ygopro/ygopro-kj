--Lyra, the Blazing Sun
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CELESTIAL_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--tap, get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--tap, get ability
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,Card.IsFaceup,0,LOCATION_BZONE,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not tc:IsFaceup() then return end
	Duel.Tap(tc,REASON_EFFECT)
	local reset_count=(Duel.GetTurnPlayer()~=tp and 2 or 1)
	--do not untap
	aux.AddTempEffectCustom(e:GetHandler(),tc,1,EFFECT_DONOT_UNTAP_START_STEP,RESET_PHASE+PHASE_DRAW,reset_count)
end
--[[
	Rulings
	Q: Can my opponent untap the creature with a spell or a creature's ability?
		A: Yes. "Solar Flare" only stops the creature from untapping at the start of your opponent's next turn.
	https://kaijudo.fandom.com/wiki/Lyra,_the_Blazing_Sun/Rulings
]]
