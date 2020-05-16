--Serpens, the Spirit Shifter
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CELESTIAL_DRAGON,RACE_TERROR_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to shield zone
	aux.AddTriggerEffect(c,0,EVENT_BANISHED,true,aux.CheckDeckFunction(PLAYER_SELF),scard.op1,nil,aux.LeaveBZoneCondition(PLAYER_SELF))
end
--to shield zone
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendDecktoptoSZone(tp,eg:GetCount())
end
