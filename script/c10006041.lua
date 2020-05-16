--Herald of Infernus
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--to battle zone
	aux.AddSingleTriggerEffectWinBattle(c,0,true,scard.tg1,scard.op1)
end
--to battle zone
function scard.tbfilter(c)
	return not c:IsEvolution() and c:IsRaceCategory(RACECAT_DRAGON)
end
scard.tg1=aux.SendtoBZoneTarget(scard.tbfilter,LOCATION_HAND,0)
scard.op1=aux.SendtoBZoneOperation(PLAYER_SELF,scard.tbfilter,LOCATION_HAND,0,1)
