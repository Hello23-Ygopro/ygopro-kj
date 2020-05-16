--Storm Seeker
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--confirm deck (to hand)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.DecktopSendtoHandOperation(PLAYER_SELF,Card.IsSpell,1,nil,nil,SEQ_DECK_BOTTOM,true,true))
end
