--Andromeda of the Citadel
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CELESTIAL_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to shield zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.DecktopSendtoSZoneOperation(PLAYER_SELF,2))
	--tap
	aux.AddTriggerEffect(c,1,EVENT_ATTACK_ANNOUNCE,nil,nil,scard.op1,nil,scard.con1)
end
--tap
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():GetControler()~=tp and Duel.GetAttackTarget()==nil
end
scard.op1=aux.TapOperation(PLAYER_OPPO,Card.IsFaceup,0,LOCATION_BZONE,1)
