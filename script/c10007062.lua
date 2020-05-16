--Mana Tick
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MEGABUG)
	--creature
	aux.EnableCreatureAttribute(c)
	--confirm deck (to hand)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.DecktopSendtoHandOperation(PLAYER_SELF,scard.thfilter,4,0,1,SEQ_DECK_BOTTOM,nil,true))
end
--confirm deck (to hand)
function scard.thfilter(c)
	return c:KJIsRace(RACE_MEGABUG)
end
