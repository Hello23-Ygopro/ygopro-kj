--Eye Spy
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BATTLE_SPHERE)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--skirmisher
	aux.EnableSkirmisher(c)
	--confirm deck (to hand)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.DecktopSendtoHandOperation(PLAYER_SELF,scard.thfilter,3,0,1,SEQ_DECK_BOTTOM))
end
--confirm deck (to hand)
function scard.thfilter(c)
	return c:IsCreature() and c:IsHasEffect(EFFECT_BLOCKER)
end
