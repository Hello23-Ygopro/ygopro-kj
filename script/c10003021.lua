--Razorpine Tree
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STAR_SENTINEL)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--skirmisher
	aux.EnableSkirmisher(c)
	--untap
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_END,nil,nil,aux.SelfUntapOperation,nil,aux.SelfBlockCondition)
end
