--Sumo Artichoke
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_WILD_VEGGIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--tap
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,aux.SelfTapTarget,aux.SelfTapOperation)
	--must be attacked
	aux.EnableMustBeAttacked(c)
end
