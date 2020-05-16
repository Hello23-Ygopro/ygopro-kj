--Deflector Pod
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ENFORCER)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--skirmisher
	aux.EnableSkirmisher(c)
	--untap
	aux.AddSingleTriggerEffect(c,0,EVENT_CUSTOM+EVENT_BLOCK,true,scard.tg1,scard.op1)
end
--untap
function scard.posfilter(c)
	return c:IsFaceup() and not c:IsHasEffect(EFFECT_BLOCKER) and c:IsAbleToUntap()
end
scard.tg1=aux.CheckCardFunction(scard.posfilter,LOCATION_BZONE,0)
scard.op1=aux.UntapOperation(PLAYER_SELF,scard.posfilter,LOCATION_BZONE,0,1)
